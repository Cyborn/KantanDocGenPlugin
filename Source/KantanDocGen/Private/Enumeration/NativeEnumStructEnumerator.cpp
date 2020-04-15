// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright (C) 2016-2017 Cameron Angus. All Rights Reserved.

#include "NativeEnumStructEnumerator.h"
#include "KantanDocGenLog.h"
#include "UObject/UnrealType.h"
#include "UObject/Package.h"
#include "UObject/UObjectHash.h"
#include "BlueprintActionDatabase.h"
#include "K2Node_SwitchEnum.h"
#include "K2Node_BreakStruct.h"
#include "BlueprintFieldNodeSpawner.h"

FNativeEnumStructEnumerator::FNativeEnumStructEnumerator(
	FName const& InModuleName
)
{
	CurIndex = 0;

	Prepass(InModuleName);
}

void FNativeEnumStructEnumerator::Prepass(FName const& ModuleName)
{
	// For native package, all classes are already loaded so it's no problem to fully enumerate during prepass.
	// That way we have more info for progress estimation.

	// Attempt to find the package
	auto PkgName = TEXT("/Script/") + ModuleName.ToString();

	// Attempt to find the package
	auto Package = FindPackage(nullptr, *PkgName);
	if (Package == nullptr)
	{
		// If it is not in memory, try to load it.
		Package = LoadPackage(nullptr, *PkgName, LOAD_None);
	}
	if (Package == nullptr)
	{
		UE_LOG(LogKantanDocGen, Warning, TEXT("Failed to find specified package '%s', skipping."), *PkgName);
		return;
	}

	// Make sure it's fully loaded (probably unnecessary since only native packages here, but no harm)
	Package->FullyLoad();

	// Cache list of spawners for this object
	auto& BPActionMap = FBlueprintActionDatabase::Get().GetAllActions();

	for (TPair<FObjectKey, TArray<UBlueprintNodeSpawner*>> Pair : BPActionMap)
	{
		for (UBlueprintNodeSpawner* Spawner : Pair.Value)
		{
			if (Spawner->NodeClass == UK2Node_SwitchEnum::StaticClass() || Spawner->NodeClass == UK2Node_BreakStruct::StaticClass())
			{
				if (UBlueprintFieldNodeSpawner* FieldSpawner = Cast<UBlueprintFieldNodeSpawner>(Spawner))
				{
					FString PackageName;
					FPackageName::TryConvertFilenameToLongPackageName(*FieldSpawner->GetField()->GetPathName(), PackageName);
					if (PackageName.StartsWith(PkgName))
					{
						// This will contain many of the same object if we don't add unique.
						ObjectList.AddUnique(TWeakObjectPtr<UObject>(Pair.Key.ResolveObjectPtr()));
					}
				}
			}
		}
	}
}

UObject* FNativeEnumStructEnumerator::GetNext()
{
	UObject* CurObject = CurIndex < ObjectList.Num() ? ObjectList[CurIndex++].Get() : nullptr;
	if (CurObject)
	{
		FString PackageName;
		FPackageName::TryConvertFilenameToLongPackageName(*CurObject->GetPathName(), PackageName);
		UE_LOG(LogKantanDocGen, Log, TEXT("Enumerating object '%s' in package '%s'"), *CurObject->GetName(), *PackageName);
	}
	return CurObject;
}

float FNativeEnumStructEnumerator::EstimateProgress() const
{
	return (float)CurIndex / (ObjectList.Num() - 1);
}

int32 FNativeEnumStructEnumerator::EstimatedSize() const
{
	return ObjectList.Num();
}

