//
//  ConnectionController.swift
//  macSCP
//
//  Created by Nevil Macwan on 26/04/21.
//

import Foundation
import NMSSH

func createSession(address:String, username:String, password:String, keypath:String, iskey: Bool) -> NMSSHSession {
    let session = NMSSHSession(host: address, andUsername: username)
    session.connect()
    if iskey {
        let privateKey = try! String(contentsOfFile: keypath)
        if session.isConnected == true {
            session.authenticateBy(inMemoryPublicKey: "", privateKey: privateKey, andPassword: nil)
            print("Connected to the server succesfully.")
        } else {
            print("Error in authenticate!")
        }
    } else {
        if session.isConnected == true {
            session.authenticate(byPassword: password)
        } else {
            print("Error in authenticate!")
        }
    }
    return session
}

func executeCommand(session: NMSSHSession, command: String) -> String {
    let error: NSErrorPointer = nil
    return session.channel.execute(command, error: error)
}

func getFileList(session: NMSSHSession, dir: String) -> [NMSFTPFile] {
    if !session.isConnected {
        session.connect()
    }
    let sftp =  NMSFTP(session: session)
    sftp.connect()
    return sftp.contentsOfDirectory(atPath: dir) ?? []
}

func deleteFile(session: NMSSHSession, pathToDelete: String) {
}

func downloadFile(session: NMSSHSession, pathToDownload: String, downloadDirectory: String) {
    if !session.isConnected {
        session.connect()
    }
    let sftp = NMSFTP(session: session)
    sftp.connect()
//    sftp.copyContents(ofPath: <#T##String#>, toFileAtPath: <#T##String#>, progress: <#T##((UInt, UInt) -> Bool)?##((UInt, UInt) -> Bool)?##(UInt, UInt) -> Bool#>)
}

func makeDirectoy(session: NMSSHSession, atPath: String) {
    if !session.isConnected {
        session.connect()
    }
    let sftp = NMSFTP(session: session)
    sftp.connect()
    sftp.createDirectory(atPath: atPath)
}

func deleteDirectoy(session: NMSSHSession, atPath: String) {
    if !session.isConnected {
        session.connect()
    }
    let sftp = NMSFTP(session: session)
    sftp.connect()
    sftp.removeDirectory(atPath: atPath)
}
