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

clickInVertex :: Int -> Int -> Vertex -> Bool
clickInVertex x y vtx
    | x > avx && x < bvx = True
    | y > avy && y < bvy = True
        where
            avx = min (fst $ position vtx) (fst $ texCoords vtx)
            bvx = max (fst $ position vtx) (fst $ texCoords vtx)

            avy = min (snd $ position vtx) (snd $ texCoords vtx)
            bvy = max (snd $ position vtx) (snd $ texCoords vtx)
