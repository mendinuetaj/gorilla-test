use std::io;
use actix_web::{App, HttpServer, HttpResponse, post};
use std::fs::File;
use std::io::Write;
use uuid::Uuid;

#[actix_web::main]
async fn main() -> io::Result<()> {
    HttpServer::new(move || App::new().service(process_web_hook))
        .backlog(1024)
        .bind("0.0.0.0:8080")?
        .run()
        .await
}

#[post("/webhooks")]
pub async fn process_web_hook() -> HttpResponse {
    match create_random_file() {
        Ok(_) => {
            HttpResponse::Ok()
                .content_type("application/json")
                .body("{\"message\":\"File create successfully !\"}")
        }
        Err(_) => {
            HttpResponse::InternalServerError()
                .content_type("application/json")
                .body("{\"error\":\"Error creating file !\"}")
        }
    }

}
fn create_random_file() -> std::io::Result<()> {
    let id = Uuid::new_v4();
    let mut file = File::create(format!("/home/gorilla-admin/{}.txt",id))?;
    file.write_all(b"Push request")?;
    Ok(())
}