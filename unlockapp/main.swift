//
//  main.swift
//  unlockapp
//
//  Created by Jack Hedaya on 10/27/16.
//  Copyright © 2016 Jack Hedaya. All rights reserved.
//

import Foundation

let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent

let arguments = CommandLine.arguments

if CommandLine.arguments.count == 1
{
    print("usage:")
    print("\(executableName) pathToApplication")
} else if CommandLine.arguments.count > 2
{
    for i in 2...arguments.count - 1
    {
        print("Extra argument: \'\(arguments[i])\'")
    }
    
    print("usage:")
    print("\(executableName) pathToApplication")
} else
{
    
    let fileManager = FileManager.default
    var isDir : ObjCBool = true
    if !fileManager.fileExists(atPath: "/usr/local/bin/lckapps", isDirectory:&isDir) {
        
        let crtTask = Process()
        crtTask.launchPath = "/bin/mkdir"
        crtTask.arguments = ["/usr/local/bin/lckapps"]
        crtTask.launch()
    }
    
    if fileManager.fileExists(atPath: arguments[1], isDirectory:&isDir) {
        
        let task = Process()
        
        var appName = arguments[1].characters.split(separator: "/").map(String.init).last!
        let index = appName.index(appName.startIndex, offsetBy: appName.characters.count - 4)
        
        appName = appName.substring( to: index)
        
        task.launchPath = "/bin/mv"
        task.arguments = ["/usr/local/bin/lckapps/\(appName)", "\(arguments[1])Contents/MacOS/\(appName)"]
        task.launch()
    } else
    {
        fatalError("Application Not Found")
    }
}
