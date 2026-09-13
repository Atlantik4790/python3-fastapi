import os

from fastapi import FastAPI

app = FastAPI(title="DevOps Practice — FastAPI")

# In-memory data. No database needed for this practice target.
ITEMS = [
    {"id": 1, "name": "Widget", "price": 9.99},
    {"id": 2, "name": "Gadget", "price": 14.50},
    {"id": 3, "name": "Gizmo", "price": 7.25},
    {"id": 4, "name": "Doohickey", "price": 21.00},
]


@app.get("/")
def root():
    return {
        "message": "Welcome! This is a DevOps practice target.",
        "stack": "Python + FastAPI (served by uvicorn)",
    }


@app.get("/health")
def health():
    return {"status": "ok"}


@app.get("/api/items")
def list_items():
    return ITEMS


if __name__ == "__main__":
    import uvicorn

    # Read PORT from env (12-factor). Default to 8000.
    port = int(os.environ.get("PORT", "8000"))
    uvicorn.run(app, host="0.0.0.0", port=port)
