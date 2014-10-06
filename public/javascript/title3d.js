var WIDTH = 200, HEIGHT = 100;

    var renderer, scene, camera, cube;
    
    function onLoad(){
       var container = document.getElementById("container");

       renderer = new THREE.WebGLRenderer();
       renderer.setSize(WIDTH, HEIGHT);
       renderer.setClearColor( 0xffffff, 1 );
       container.appendChild(renderer.domElement);

       camera = new THREE.PerspectiveCamera(45, WIDTH /HEIGHT , 0.1, 1000);
       scene = new THREE.Scene();
    
       scene.add(camera);
       camera.position.z = 300;
    
       cube = new THREE.Mesh( new THREE.TextGeometry("MANGO") );
       cube.position.y = 0;
       cube.position.z = -150;
       scene.add(cube);
    
       requestAnimationFrame(render);
    };
    
    function render(){
      requestAnimationFrame(render);
      
      cube.rotation.y += 0.01;
      
      renderer.render(scene, camera);
    };