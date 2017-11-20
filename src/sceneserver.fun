/---------------------
 -- sceneserver.fun
 --
 -- A simple customizable 3D content server.
 --
 -- Copyright (c) 2013-2017 by Michael St. Hippolyte
 --
 --/
 
site sceneserver {

    adopt three

    int major_version = 0
    int minor_version = 2

    version = major_version + "." + minor_version

    config_filename = file_base + "/world.json"

    world_file_path = file_base + "/" + this_config.world_path 
    world_name = this_config.world_name
    
    init {
        three.set_logging_level(three.LOG_DEBUG);
        load_config(config_filename);
        load_world(world_name, world_file_path);
        set_main_world(world_name);
    }
    
    session_init {
        log("scenserver.session_init called");
    }


    page(params) sceneserver_basepage(params{}),(path, params{}) {
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

        sub;
    }

    /** sceneserver request base class **/
    req {
       name [?]
       get(nm) [| Unrecognized request. |]
    }
    
    /-- request types --/
    
    req scene_req {
        name = "scene"
        get(nm) = get_scene(nm)
    }

    req agent_req {
        name = "agent";
        get(nm) = get_agent(nm)
    }
    
    req prop_req {
        name = "prop";
        get(nm) = get_prop(nm)
    }

    req page_req {
        name = "page";
        get(nm) = get_page(nm)
    }
        
    req info_req {
        name = "info";
        get(nm) = "<h2>Sceneserver " + version + "<br>Open server for multiuser, interconnected 3D content.</h2>"
    }    

    /-- request constructor table --/
    req[] supported_reqs = [ scene_req, agent_req, prop_req, info_req, page_req ] 
    req{} req_types = { for req r in supported_reqs {
                            r.name: r
                        }
                      }

    public global response index(request r) {
        scene_viewer(initial_scene_name);
    }
    public dynamic response general_response(r_path),(r_name, request r) {
        title = "sceneserver"

        path = (r_path ? r_path : r.path_info)
        npath = (starts_with(path, "/") ? substring(path, 1) : path)
            
        int ix = last_index_of(npath, "/")
        rname = (ix < 0 ? npath : substring(npath, ix + 1))
        rtype = (ix > 0 ? substring(npath, 0, ix) : "")

        req rq = req_types[rtype]

        rq.get(rname);
    }

    /---- error pages ----/
    
    public page error_page(msg, ctx) {
        [| <h2>Error: /]            
        msg;
        [| </h2> |]
        
        with (ctx) {
            ctx;
        }
    }   

    public error_page("No scene specified.", ctx) scene_not_specified_error(ctx) [/]
    public error_page("Scene not found.", ctx) scene_not_found_error(ctx) [/]   


    /---- object retrieval functons ----/ 


    dynamic get_agent(name) {
        ("~~== agent " + (name ? name : "bbhphhhtt") + " ==~~");    
    }

    dynamic get_prop(name) {
        ("~~== prop " + (name ? name : "bbhphhhtt") + " ==~~");    
    }

    dynamic get_page(name) {
        ("~~== page " + (name ? name : "bbhphhhtt") + " ==~~");    
    }


    /---- pseudofiles ----/

    public js {
        lib {
            three {
                public js {
                    include_file("../3p/lib/three.js");
                }
            }
            stats {
                public js {
                    include_file("../3p/lib/stats.min.js");
                }
            }
        }
    }

}
 
