//
//  DataController.swift
//  CrazyJobJournal
//
//  Created by Nanashi Kai Ni on 28/02/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Model")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Error saving data")
        }
        
    }
    
    func addJob(title: String, desc: String, imageName: String, icon: String, context: NSManagedObjectContext) {
        let job = JobE(context: context)
        job.id = UUID()
        job.title = title
        job.desc = desc
        job.imageName = imageName
        job.icon = icon
        job.isFound = false
        job.isChosen = false
        job.toTask = NSSet()
        save(context: context)
    }
    
    func editJob(job: JobE, isFound: Bool, context: NSManagedObjectContext){
        job.isFound = isFound
        save(context: context)
    }
    
    func editJob(job: JobE, isChosen: Bool, context: NSManagedObjectContext){
        job.isChosen = isChosen
        save(context: context)
    }
    
    
    func addTask(title: String, desc: String, job: JobE, context: NSManagedObjectContext) {
        let task = TaskE(context: context)
        task.id = UUID()
        task.title = title
        task.desc = desc
        task.isDone = false
        task.isTaken = false
        task.toJob = job
        save(context: context)
    }
    
    func editTask(task: TaskE, isDone: Bool, context: NSManagedObjectContext) {
        task.isDone = isDone
        save(context: context)
    }
    
    func editTask(task: TaskE, title: String, context: NSManagedObjectContext) {
        task.title = title
        save(context: context)
    }
    
    func editTask(task: TaskE, isTaken: Bool, context: NSManagedObjectContext) {
        task.isTaken = isTaken
        save(context: context)
    }
    
    func addNote(desc: String, task: TaskE, context: NSManagedObjectContext) -> NoteE{
        let note = NoteE(context: context)
        note.id = UUID()
        note.desc = desc
        note.date = Date.now
        note.noteForTask = task
        save(context: context)
        return note
    }
    
    func addNoteToTask(note: NoteE, task: TaskE, context: NSManagedObjectContext){
        task.taskForNote = note
        save(context: context)
    }
    
    func editNote(note: NoteE, desc: String, context: NSManagedObjectContext){
        note.desc = desc
        save(context: context)
    }
    
    func removeJob(job:JobE,context: NSManagedObjectContext){
        context.delete(job)
        save(context: context)
    }
    
    func getJob(context: NSManagedObjectContext) -> [JobE]{
        var jobs: [JobE] = []
        let request = NSFetchRequest<JobE>(entityName: "JobE")
        do{
            jobs = try context.fetch(request)
        }catch let error{
            print("Error fetching \(error.localizedDescription)")
        }
        return jobs
    }
    
    func getTask(context: NSManagedObjectContext) -> [TaskE]{
        var task: [TaskE] = []
        let request = NSFetchRequest<TaskE>(entityName: "TaskE")
        do{
            task = try context.fetch(request)
        }catch let error{
            print("Error fetching \(error.localizedDescription)")
        }
        return task
    }
    
    func getNote(context: NSManagedObjectContext) -> [NoteE]{
        var note: [NoteE] = []
        let request = NSFetchRequest<NoteE>(entityName: "NoteE")
        do{
            note = try context.fetch(request)
        }catch let error{
            print("Error fetching \(error.localizedDescription)")
        }
        return note
    }
}
