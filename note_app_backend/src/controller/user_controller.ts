import express from "express";
import { getDatabase } from "../config/mongodb_client";
import { User } from "../models/user_model";
import bcrypt from "bcrypt"
import { ObjectId } from "mongodb";

export class UserController {

    static async signUp (request: express.Request, response: express.Response) {
        const user: User = request.body

        let db = getDatabase()

        let userCollection = db.collection("users")

        const checkUserInDb = {
            email: user.email
        }

        const data = await userCollection.find(checkUserInDb).toArray()
        if (data.length != 0) {
            response.status(403).json({
                "status": "Failure",
                "response": "Email already exist"
            })
        }
        else {
            const salt = await bcrypt.genSalt(10)
            user.password = await bcrypt.hash(user.password, salt)

            const responseData = await userCollection.insertOne(user)
            console.log(`responseData : ${responseData}`)
            const objectId = responseData.insertedId;
            const userInfo = await userCollection.find({ "_id": new ObjectId(objectId) }).toArray()

            const userResponseData = userInfo[0]
            userResponseData.password = "";

            response.status(200).json({
                "status": "Success",
                "response": userResponseData
            })
        }
    }

    static async signIn (request: express.Request, response: express.Response) {
        let db = getDatabase()
        let userCollection = db.collection("users")
        const user: User = request.body

        const checkUserInDb = { email: user.email }
        const data = await userCollection.find(checkUserInDb).toArray()

        if (data.length != 0) {
            let userInfo = data[0];
            const pass = await bcrypt.compare(user.password, userInfo.password)
            if (userInfo.email == user.email && pass) {
                response.status(200).json({
                    "status": "success",
                    "response": userInfo
                })
            }
            else {
                response.status(403).json({
                    "status": "Failure",
                    "response": "Invalid email & password"
                })
            }
        }
        else {
            response.status(403).json({
                "status": "Failure",
                "response": "Invalid email & password"
            })
        }
    }
    static async myProfile (request: express.Request, response: express.Response) {
        let db = getDatabase()
        const userCollection = db.collection("users");
        const uid = request.query.uid;

        const data = await userCollection.find({ _id: new ObjectId(uid!.toString()) }).toArray();

        response.status(200).json({
            "status": "success",
            "response": data[0]

        })
    }

    static async updateProfile (request: express.Request, response: express.Response) {
        let db = getDatabase()
        const user = request.body
        const userCollection = db.collection("users")

        const updatedUser = {
            username: user.username
        }
        const userInfo = await userCollection.updateOne({ _id: new ObjectId(user.uid) }, { $set: updatedUser })
        response.status(200).json({
            "status": "success",
            "response": userInfo
        })
    }

}