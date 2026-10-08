from sys import argv
import torch
import torch.nn as nn
from sklearn.datasets import load_digits
from sklearn.model_selection import train_test_split

lr = float(argv[1])
task = argv[2]
device = "cuda" if torch.cuda.is_available() else "cpu"

# Small dataset: 8x8 handwritten digits, 10 classes
X, y = load_digits(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X / 16.0, y, random_state=0)
X_train, X_test = torch.tensor(X_train, dtype=torch.float32).to(device), torch.tensor(X_test, dtype=torch.float32).to(device)
y_train, y_test = torch.tensor(y_train).to(device), torch.tensor(y_test).to(device)

model = nn.Sequential(nn.Linear(64, 64), nn.ReLU(), nn.Linear(64, 10)).to(device)
opt = torch.optim.Adam(model.parameters(), lr=lr)
loss_fn = nn.CrossEntropyLoss()

for epoch in range(200):
    opt.zero_grad()
    loss = loss_fn(model(X_train), y_train)
    loss.backward()
    opt.step()

acc = (model(X_test).argmax(dim=1) == y_test).float().mean().item()
print(f"task {task}: lr={lr}  device={device}  test accuracy={acc:.3f}")