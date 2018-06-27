--
-- app/Main.hs for FUN
--
-- Made by Tanguy Gérôme
--        <me@kapno.cc>
--      on Tue Jun 26 16:32:11 2018
--

module Main where

import Lib

import System.Random
import Debug.Trace

import SFML.Graphics
import SFML.Window
import SFML.Window.Event


colors :: [Color]
colors = [red, blue, green, magenta, cyan, yellow]

nColors :: Int
nColors = length colors


main = do
  vMode <- getDesktopMode
  wnd <- createRenderWindow vMode "SFML Haskell Demo" [] Nothing
  va <- createVA
  cl <- createClock
  setPrimitiveType va Triangles
  loop wnd va cl
  destroy va
  destroy wnd

newRandPoint wnd va = do col <- randomRIO (0, nColors)
                         vec <- getWindowSize wnd
                         let v = getVector2u vec
                         x <- randomRIO (10, (fst v) - 10)
                         y <- randomRIO (10, (snd v) - 10)
                         appendVertex va col x y 25 20
                         appendVertex va col (x + 15) y 10 10
                         appendVertex va col (x + 20) y 10 16

loop :: RenderWindow -> VertexArray -> Clock -> IO ()
loop wnd va cl = do
  t <- getElapsedTime cl
  ret <- processEvt wnd va
  case ret of
    False -> return ()
    True -> do
      clearRenderWindow wnd black
      drawVertexArray wnd va Nothing
      display wnd
      if asMilliseconds t >= 500 then newRandPoint wnd va >> restartClock cl>> loop wnd va cl
                                 else loop wnd va cl


appendVertex :: VertexArray -> Int -> Int -> Int -> Int -> Int -> IO ()
appendVertex va f x y sx sy = do
  let color = colors !! (f `mod` nColors)
      x1 = fromIntegral $ x - sx `div` 2
      x2 = fromIntegral $ x + sx `div` 2
      y1 = fromIntegral $ y - sy `div` 2
      y2 = fromIntegral $ y + sy `div` 2
      corners = [ Vec2f x1 y1, Vec2f x1 y2, Vec2f x2 y2,
                  Vec2f x1 y1, Vec2f x2 y2, Vec2f x2 y1 ]
      vtx v = Vertex v color v
      vertices = map vtx corners
  mapM_ (appendVA va) vertices

buttonToInt MouseLeft = 0
buttonToInt MouseMiddle = 1
buttonToInt MouseRight = 2
buttonToInt _ = 3

processEvt :: RenderWindow -> VertexArray -> IO Bool
processEvt wnd va = do
  evt <- pollEvent wnd
  case evt of
    Just SFEvtClosed -> return False
    Just (SFEvtKeyPressed {code = KeyEscape}) -> return False
    Just (SFEvtMouseButtonPressed f x y) -> appendVertex va (buttonToInt f) x y 20 20 >> processEvt wnd va
    Nothing -> return True
    _ -> processEvt wnd va
