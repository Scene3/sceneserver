/---------------------
 -- sceneserver_example.fun
 --
 -- An example site using sceneserver.
 --
 -- Copyright (c) 2013 by Michael St. Hippolyte
 --
 --/
 
site sceneserver_example {

    adopt sceneserver
    adopt three

    /--------------------/
    /----  the scene  ----/

    scene sample_scene {
        phong_material blue_material {
            undecorated color = 0x3333CC
        }
            
        mesh(cube_geometry(10, 10, 10), blue_material) blue_cube {
            position pos = position(0, 2, 0)
        }
        point_light(0xFFFF33) bright_yellow_light {
            position pos = position(0, 50, 0)
        }
            
        point_light(0xFF0000) bright_red_light {
            position pos = position(-30, 13, 20)
        }

        point_light(0x00FF00) bright_green_light {
            position pos = position(30, 13, 20)
        }

        point_light(0x5555FF) bright_blue_light {
            position pos = position(0, -50, 0)
        }

        point_light(0xAAAAAA) soft_white_light {
            position pos = position(0, 2, 40)
        }

        three_object[] objs = [
            blue_cube,
            bright_yellow_light,
            bright_red_light,
            bright_green_light,
            bright_blue_light,
            soft_white_light
        ]
            
        next_frame [|
            blue_cube.rotation.x += 0.02;
            blue_cube.rotation.y -= 0.02;
            blue_cube.rotation.z -= 0.01;
        |]
    }


    
    /---- home page ----/
  
    page(params) index(params{}) {

        /-------------------------/
        /---- meta properties ----/

        title = "sceneserver example"
        viewport [| width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0 |]

        style [| 
            html, body { 
                width: 100%;
                height: 100%;
                min-width: 100%;
                min-height: 100%;
                margin: 0;
                background: black;
            }
        |]

      
        scene_viewer(sample_scene);
        
        log("    >>> current_scene: " + current_scene.name); 
        
    }

    test {
        scene_viewer(sample_scene);
    }

}
 
