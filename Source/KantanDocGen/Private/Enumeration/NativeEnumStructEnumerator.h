// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

// Copyright (C) 2016-2017 Cameron Angus. All Rights Reserved.

#pragma once

#include "ISourceObjectEnumerator.h"


class FNativeEnumStructEnumerator: public ISourceObjectEnumerator
{
public:
	FNativeEnumStructEnumerator(
		FName const& InModuleName,
		TArray< FName > const& ExclNames
	);

public:
	virtual UObject* GetNext() override;
	virtual float EstimateProgress() const override;
	virtual int32 EstimatedSize() const override;

protected:
	void Prepass(FName const& ModuleName, TArray< FName > const& ExclNames);

protected:
	TArray< TWeakObjectPtr< UObject > > ObjectList;
	int32 CurIndex;
};


