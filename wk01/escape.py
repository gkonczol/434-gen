import argparse
import inspect
import random
import pickle
import turtle

def draw_bag():
  bag = turtle.Turtle()
  bag.pen(pencolor='red', pensize=4)
  bag.penup()
  bag.goto(-35, 35)
  bag.pendown()
  bag.right(90)
  bag.forward(70)
  bag.left(90)
  bag.forward(70)
  bag.left(90)
  bag.forward(70)
  bag.hideturtle()

def draw_line():
  angle = 0
  step = 5
  t = turtle.Turtle()
  while not escaped(t.position()):
    t.left(angle)
    t.forward(step)

def escaped(position)
  x = int(position[0])
  y = int(position[1])
  return x < -35 or x > 35 or y < -35 or y > 35