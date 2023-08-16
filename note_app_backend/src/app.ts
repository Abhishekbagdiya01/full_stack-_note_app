import express, { urlencoded } from 'express';
import { connectTODatabase } from './config/mongodb_client';
import appLogger from './middleware/app_logger';
import cors from 'cors';
import userRouter from './router/user_router';
import noteRouter from './router/note_router';


const app: express.Application = express()
app.use(cors())
app.use(appLogger)
app.use(express.json())
app.use(urlencoded({ extended: false }))
app.use("/v1/user/", userRouter)
app.use("/v1/note/",noteRouter)
const hostName = "192.168.29.235"
const portNumber = 5000

app.listen(portNumber, hostName, async () => {
    await connectTODatabase();
    console.log(`Welcome to the NoteApp backend server  http://${hostName}:${portNumber}/`)
})