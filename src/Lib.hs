--
-- src/Lib.hs for FUN
--
-- Made by Tanguy Gérôme
--        <me@kapno.cc>
--      on Tue Jun 26 16:32:16 2018
--

module Lib where

import SFML.Graphics
import SFML.System.Vector2


getVector2u :: Vec2u -> (Int, Int)
getVector2u v = ((w !! 0), (w !! 1))
        where w = map (read) $ drop 1 $ words $ show v

getVector2f :: Vec2f -> (Float, Float)
getVector2f v = ((w !! 0), (w !! 1))
        where w = map (read) $ drop 1 $ words $ show v

clickInVertex :: Int -> Int -> Vertex -> Bool
clickInVertex x y vtx
    | x > avx && x < bvx = True
    | y > avy && y < bvy = True
        where

            (posx, posy) = getVector2f $ position vtx
            (texx, texy) = getVector2f $ texCoords vtx

            avx = floor $ min posx texx
            bvx = floor $ max posx texx

            avy = floor $ min posy texy
            bvy = floor $ max posy texy
