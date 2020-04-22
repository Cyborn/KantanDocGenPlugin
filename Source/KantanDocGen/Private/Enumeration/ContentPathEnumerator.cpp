// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright (C) 2016-2017 Cameron Angus. All Rights Reserved.

#include "ContentPathEnumerator.h"
#include "KantanDocGenLog.h"
#include "AssetRegistryModule.h"
#include "ARFilter.h"
#include "Engine/Blueprint.h"
#include "Animation/AnimBlueprint.h"


FContentPathEnumerator::FContentPathEnumerator(
	FName const& InPath,
	TArray< FName > const& ExclNames
)
{
	CurIndex = 0;

	Prepass(InPath, ExclNames);
}

void FContentPathEnumerator::Prepass(FName const& Path, TArray< FName > const& ExclNames)
{
	auto& AssetRegistryModule = FModuleManager::GetModuleChecked< FAssetRegistryModule >("AssetRegistry");
	auto& AssetRegistry = AssetRegistryModule.Get();

	FARFilter Filter;
	Filter.bRecursiveClasses = true;
	Filter.ClassNames.Add(UBlueprint::StaticClass()->GetFName());
	Filter.ClassNames.Add(UStruct::StaticClass()->GetFName());
	Filter.ClassNames.Add(UEnum::StaticClass()->GetFName());
	
	// @TODO: Not sure about this, but for some reason was generating docs for 'AnimInstance' itself.
	Filter.RecursiveClassesExclusionSet.Add(UAnimBlueprint::StaticClass()->GetFName());

	FARFilter ExclFilter;
	ExclFilter.bRecursivePaths = true;
	ExclFilter.PackagePaths = ExclNames;
	
	AssetRegistry.GetAssetsByPath(Path, AssetList, true);
	AssetRegistry.RunAssetsThroughFilter(AssetList, Filter);
	AssetRegistry.UseFilterToExcludeAssets(AssetList, ExclFilter);
}

UObject* FContentPathEnumerator::GetNext()
{
	UObject* Result = nullptr;

	if(CurIndex < AssetList.Num())
	{
		auto const& AssetData = AssetList[CurIndex];
		++CurIndex;

		UE_LOG(LogKantanDocGen, Log, TEXT("Enumerating object '%s' at '%s'"), *AssetData.GetAsset()->GetName(), *AssetData.ObjectPath.ToString());

		Result = AssetData.GetAsset();
	}
	
	return Result;
}

float FContentPathEnumerator::EstimateProgress() const
{
	return (float)CurIndex / (AssetList.Num() - 1);
}

int32 FContentPathEnumerator::EstimatedSize() const
{
	return AssetList.Num();
}

