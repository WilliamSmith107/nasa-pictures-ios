//
//  NASAPicturesScreen.swift
//  AppFeature
//
//  Created by William Smith on 14/07/2025.
//

import ComposableArchitecture
import PictureFeature

@Reducer(state: .equatable)
public enum NASAPicturesScreen {
	case splashScreen
	case pictureScreen(Picture)
}
