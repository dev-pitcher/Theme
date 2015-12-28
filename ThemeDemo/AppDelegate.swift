//
// Copyright (c) 2015 Hilton Campbell
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit
import Theme

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let appSettings = AppSettings()
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Load and register the app's themes
        let themePath = NSBundle.mainBundle().pathForResource("Theme", ofType: "plist")
        let themeDictionary = NSDictionary(contentsOfFile: themePath!)
        ThemeController.sharedController.registerThemes(themeDictionary!)
        
        let viewController = ViewController(appSettings: appSettings)
        let navigationController = ThemeAwareNavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        // Observe theme changes
        ThemeController.sharedController.observeTheme(self, self.dynamicType.themeDidChange)
        
        return true
    }
    
    func themeDidChange(theme: Theme) {
        window?.tintColor = theme.colorForKeyPath("tintColor")
    }

}

