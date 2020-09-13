
var UNITWIDTH = 90; // Width of a cubes in the maze
//벽의 높이
var UNITHEIGHT = 150; // Height of the cubes in the maze

var camera, controls, scene, renderer;
var mapSize;

var totalCubesWide;
var collidableObjects = [];

// Flag to determine if the player can move and look around
var controlsEnabled = false;

// HTML elements to be changed
var blocker = document.getElementById('blocker');

//플레이어 움직임을 감지하는 변수
var moveForward = false;
var moveBackward = false;
var moveLeft = false;
var moveRight = false;

//플레이어 시작 위치 (y, z축)
var player_position_z;
var player_position_y;

// Velocity vector for the player
var playerVelocity = new THREE.Vector3();

// How fast the player will move
var PLAYERSPEED = 800.0;

var clock;

//플레이어 충돌감지 관련 변수
var PLAYERCOLLISIONDISTANCE = 20;


//맵(gallay)배열

//1번 전시관
var gallay1 = [
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, ],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, ],
  [1, 0, 0, 3, 1, 3, 1, 3, 0, 0, 0, 1, ],
  [1, 0, 4, 0, 0, 0, 0, 0, 1, 0, 0, 1, ],
  [1, 0, 1, 0, 2, 0, 2, 0, 6, 0, 0, 1, ],
  [1, 0, 4, 0, 0, 0, 0, 1, 1, 0, 0, 1, ],
  [1, 0, 1, 0, 2, 0, 2, 0, 6, 0, 0, 1, ],
  [1, 0, 4, 0, 0, 0, 0, 1, 1, 0, 0, 1, ],
  [1, 0, 1, 1, 0, 0, 0, 0, 6, 0, 0, 1, ],
  [1, 0, 4, 0, 0, 0, 0, 1, 1, 0, 0, 1, ],
  [1, 1, 1, 1, 5, 1, 5, 1, 1, 1, 1, 1, ]
];


// Get the pointer lock state
getPointerLock();
// Set up the game
init();
// Start animating the scene
animate();

listenForPlayerMovement();


// Get the pointer lock and start listening for if its state changes
function getPointerLock() {
  document.onclick = function () {
      container.requestPointerLock();
  }

  document.addEventListener('pointerlockchange', lockChange, false);
}

// Switch the controls on or off
function lockChange() {
  if (document.pointerLockElement === container) {
      blocker.style.display = "none";
      controls.enabled = true;
  } else {
      blocker.style.display = "";
      controls.enabled = false;
  }
}

// Set up the game
function init() {
    clock = new THREE.Clock();
   
  // Create the scene where everything will go
  scene = new THREE.Scene();

  // 안개효과
  scene.fog = new THREE.FogExp2(0xcccccc, 0);

  // Set render settings
  renderer = new THREE.WebGLRenderer();
  renderer.setClearColor(scene.fog.color);
  renderer.setPixelRatio(window.devicePixelRatio);
  renderer.setSize(window.innerWidth, window.innerHeight);

  // Render to the container
  var container = document.getElementById('container');
  container.appendChild(renderer.domElement);

  // Set camera position and view details
  camera = new THREE.PerspectiveCamera(60, window.innerWidth / window.innerHeight, 1, 2000);
  
  camera.position.y = 0; // Height the camera will be looking from
  camera.position.x = 0;
  camera.position.z = 0;

  // Add the camera to the controller, then add to the scene
  controls = new THREE.PointerLockControls(camera);
  //카메라의 위치를 조정한다.
  //카메라의 z축
  controls.getObject().position.z = 300;
  //카메라의 높이
  controls.getObject().position.y = 45;
  scene.add(controls.getObject());

  // Add the walls(cubes) of the maze
  createMazeWalls(1);
  // Add ground plane
  createGround(1);

  createSky();
  // Add boundry walls that surround the maze
  createPerimWalls();

  // Add lights to the scene
  addLights();

  // Listen for if the window changes sizes
  window.addEventListener('resize', onWindowResize, false);

}


// Add lights to the scene
function addLights() {
  var lightOne = new THREE.DirectionalLight(0xffffff);
  lightOne.position.set(1, 1, 1);
  scene.add(lightOne);

  var lightTwo = new THREE.DirectionalLight(0xffffff, .5);
  lightTwo.position.set(1, -1, -1);
  scene.add(lightTwo);
}



//맵을 만드는데 사용될 벽을 만드는 함수
function createMazeWalls(gallay_num) {
    //텍스처 변수
    var texture;
    //벽을 만드는데 사용될 재료(텍스처를 담을 변수)
    var wallMaterial;

    //1번 전시관 이라면
    if(gallay_num == 1) {
      var map = gallay1;

      // 일반벽
      var wallGeo = new THREE.BoxBufferGeometry(UNITWIDTH, UNITHEIGHT, UNITWIDTH);
     // 전시벽
      var wallGeo2 = new THREE.BoxBufferGeometry(UNITWIDTH/2, UNITHEIGHT/2, UNITWIDTH/6);
      //벽 텍스쳐1 추가
      texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/wall_texture5.jpg');
      wallMaterial = new THREE.MeshBasicMaterial({
          map: texture,
      });
       //벽 텍스쳐2 추가
       texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/wall_texture6.jpg');
       wallMaterial2 = new THREE.MeshBasicMaterial({
           map: texture,
       });
      //액자(정면)
      var frameGeoFront = new THREE.BoxGeometry(UNITWIDTH/4+15, UNITHEIGHT/6, 2);
      //액자(정면) 텍스처 추가
      texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame3.png');
      var frameMaterialFront = new THREE.MeshBasicMaterial({
          map: texture,
      });
  
       //액자(옆면)
       var frameGeoSide = new THREE.BoxGeometry(2, UNITHEIGHT/6, UNITWIDTH/4+15);
       //엑자(옆면) 텍스쳐 추가
       texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame3.png');
       var frameMaterialSide = new THREE.MeshBasicMaterial({
           map: texture,
       });
  
       //그림(정면)
      var paintingGeoFront = new THREE.BoxGeometry(UNITWIDTH/4+5, UNITHEIGHT/6-8, 1);
      //그림(정면) 텍스쳐 추가
      texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg1.png');
      var paintingMaterialFront = new THREE.MeshBasicMaterial({
          map: texture,
      });
  
        //그림(옆면)
        var paintingGeoSide = new THREE.BoxGeometry(1, UNITHEIGHT/6-8, UNITWIDTH/4+5);
        //벽 텍스쳐 추가(**추가부분**)
        texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg2.jpeg');
        var paintingMaterialSide = new THREE.MeshBasicMaterial({
            map: texture,
        });
  
        //액자2(정면)
      var frameGeoFront2 = new THREE.BoxGeometry(UNITWIDTH/4+15, UNITHEIGHT/4, 2);
      //엑자2(정면) 텍스쳐 추가
      texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame4.jpg');
      var frameMaterialFront2 = new THREE.MeshBasicMaterial({
          map: texture,
      });
  
       //액자2(옆면)
       var frameGeoSide2  = new THREE.BoxGeometry(2, UNITHEIGHT/4, UNITWIDTH/4+15);
       //엑자2(옆면) 텍스쳐 추가
       texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame4.jpg');
       var frameMaterialSide2 = new THREE.MeshBasicMaterial({
           map: texture,
       });
  
       //그림2(정면)
       var paintingGeoFront2 = new THREE.BoxGeometry(UNITWIDTH/4+8, UNITHEIGHT/6+6, 1);
      //그림2(정면) 텍스쳐 추가
      texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg3.jpg');
      var paintingMaterialFront2 = new THREE.MeshBasicMaterial({
          map: texture,
      });
  
        //그림2(옆면)
        var paintingGeoSide2 = new THREE.BoxGeometry(1, UNITHEIGHT/6+6, UNITWIDTH/4+8);
        //그림2(옆면) 텍스쳐 추가
        texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg4.jpeg');
        var paintingMaterialSide2 = new THREE.MeshBasicMaterial({
            map:  texture,
        });
  
       //텍스처를 반복해서 촘촘하게 출력되게 한다(중요)
       wallMaterial.map.repeat.x=1;  //20번반복
       wallMaterial.map.repeat.y=1;  //20번반복
       wallMaterial.map.wrapS=THREE.RepeatWrapping;
       wallMaterial.map.wrapT=THREE.RepeatWrapping;
  
      // Keep cubes within boundry walls
          var widthOffset = UNITWIDTH / 2;
      // Put the bottom of the cube at y = 0
          var heightOffset = UNITHEIGHT / 2;
          var heightOffset2 = UNITHEIGHT / 4;
  
      // See how wide the map is by seeing how long the first array is
    totalCubesWide = map[0].length;
  
    // Place walls where 1`s are
    }
   
  // 맵 생성 부문
  for (var i = 0; i < totalCubesWide; i++) {
    for (var j = 0; j < map[i].length; j++) {
      // If a 1 is found, add a cube at the corresponding position
      //일반벽(1)
      if (map[i][j] == 1) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        scene.add(wall);
        collidableObjects.push(wall);
      }
      //전시기둥(그림_앞쪽)(2)
      if (map[i][j] == 2) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo2, wallMaterial2);
        var photoFrame = new THREE.Mesh(frameGeoFront, frameMaterialFront);
        var photo = new THREE.Mesh(paintingGeoFront, paintingMaterialFront);

        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset2;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset +8;
        photoFrame.position.y = heightOffset2+10;
        photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset +8.6;
        photo.position.y = heightOffset2+10;
        photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        
        scene.add(wall);
        scene.add(photoFrame);
        scene.add(photo);
        collidableObjects.push(wall);
        collidableObjects.push(photoFrame);
        collidableObjects.push(photo);
      }

      //전시벽(그림_앞쪽)(3)
      if (map[i][j] == 3) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        var photoFrame = new THREE.Mesh(frameGeoFront, frameMaterialFront);
        var photo = new THREE.Mesh(paintingGeoFront, paintingMaterialFront);

        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset +47;
        photoFrame.position.y = heightOffset-30;
        photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset +47.6;
        photo.position.y = heightOffset2+7.5;
        photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        
        scene.add(wall);
        scene.add(photoFrame);
        scene.add(photo);
        collidableObjects.push(wall);
        collidableObjects.push(photoFrame);
        collidableObjects.push(photo);
      }
      //전시벽(그림왼쪽)(4)
      if (map[i][j] == 4) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        var photoFrame = new THREE.Mesh(frameGeoSide, frameMaterialSide);
        var photo = new THREE.Mesh(paintingGeoSide, paintingMaterialSide);

        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        photoFrame.position.y = heightOffset-30;
        photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset +47;

        photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        photo.position.y = heightOffset2+7.5;
        photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset+47.6;
        
        scene.add(wall);
        scene.add(photoFrame);
        scene.add(photo);
        collidableObjects.push(wall);
        collidableObjects.push(photoFrame);
        collidableObjects.push(photo);
      }
      //전시벽(그림_뒷쪽)(5)
      if (map[i][j] == 5) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        var photoFrame = new THREE.Mesh(frameGeoFront2, frameMaterialFront2);
        var photo = new THREE.Mesh(paintingGeoFront2, paintingMaterialFront2);
      
        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset-49;
        photoFrame.position.y = heightOffset-30;
        photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset-50;
        photo.position.y = heightOffset2+7;
        photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        
        scene.add(wall);
        scene.add(photoFrame);
        scene.add(photo);
        collidableObjects.push(wall);
        collidableObjects.push(photoFrame);
        collidableObjects.push(photo);
      }

       //전시벽(그림_오른쪽)(6)
       if (map[i][j] == 6) {
        // Make the cube
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        var photoFrame = new THREE.Mesh(frameGeoSide2, frameMaterialSide2);
        var photo = new THREE.Mesh(paintingGeoSide2, paintingMaterialSide2);
      
        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        photoFrame.position.y = heightOffset-30;
        photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset-45;

        photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        photo.position.y = heightOffset2+7;
        photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset-46;
        
        scene.add(wall);
        scene.add(photoFrame);
        scene.add(photo);
        collidableObjects.push(wall);
        collidableObjects.push(photoFrame);
        collidableObjects.push(photo);
      }

    }

  }
}
   
//바닥을 만드는 함수
function createGround(gallay_num) {
    // Create the ground based on the map size the matrix/cube size produced
    mapSize = totalCubesWide * UNITWIDTH;

    //벽 텍스쳐 추가(**추가부분**)
    var textureDirt;
    switch(gallay_num){
      case 1:
        textureDirt = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/gallay1_floor_texture.jpg');
      break;
    }
    
    // ground
    var groundGeo = new THREE.PlaneGeometry(mapSize, mapSize);
    var groundMat = new THREE.MeshBasicMaterial({
        map: textureDirt,
        side: THREE.DoubleSide,
        shading: THREE.FlatShading
    });

    //텍스처를 반복해서 촘촘하게 출력되게 한다(중요)
    groundMat.map.repeat.x=20;  //20번반복
    groundMat.map.repeat.y=20;  //20번반복
    groundMat.map.wrapS=THREE.RepeatWrapping;
    groundMat.map.wrapT=THREE.RepeatWrapping;
  
    var ground = new THREE.Mesh(groundGeo, groundMat);
    ground.position.set(0, 1, 0);
    ground.rotation.x = degreesToRadians(90);
    scene.add(ground);
  }

  //천장을 만드는 함수
function createSky() {
    // Create the ground based on the map size the matrix/cube size produced
    mapSize = totalCubesWide * UNITWIDTH;//벽 텍스쳐 추가(**추가부분**)
    var textureDirt = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/wall_texture5.jpg');

    
    // ground
    var groundGeo = new THREE.PlaneGeometry(mapSize, mapSize);
    var groundMat = new THREE.MeshBasicMaterial({
        map: textureDirt,
        side: THREE.DoubleSide,
        shading: THREE.FlatShading
    });
    
    //텍스처를 반복해서 촘촘하게 출력되게 한다(중요)
    groundMat.map.repeat.x=10;  //20번반복
    groundMat.map.repeat.y=10;  //20번반복
    groundMat.map.wrapS=THREE.RepeatWrapping;
    groundMat.map.wrapT=THREE.RepeatWrapping;

    var ground = new THREE.Mesh(groundGeo, groundMat);
    //벽 높이 만큼 올림
    ground.position.set(0, UNITHEIGHT, 0);
    ground.rotation.x = degreesToRadians(90);
    scene.add(ground);
  }
  
  // Make the four perimeter walls for the maze
  function createPerimWalls() {
      var halfMap = mapSize / 2;  // Half the size of the map
      var sign = 1;               // Used to make an amount positive or negative
  
      // Loop through twice, making two perimeter walls at a time
      for (var i = 0; i < 2; i++) {
          var perimGeo = new THREE.PlaneGeometry(mapSize, UNITHEIGHT);
          // Make the material double sided
          var perimMat = new THREE.MeshPhongMaterial({ color: 0x81ecec, side: THREE.DoubleSide });
          // Make two walls
          var perimWallLR = new THREE.Mesh(perimGeo, perimMat);
          var perimWallFB = new THREE.Mesh(perimGeo, perimMat);
  
          // Create left/right walls
          perimWallLR.position.set(halfMap * sign, UNITHEIGHT / 2, 0);
          perimWallLR.rotation.y = degreesToRadians(90);
          scene.add(perimWallLR);
          collidableObjects.push(perimWallLR);
          // Create front/back walls
          perimWallFB.position.set(0, UNITHEIGHT / 2, halfMap * sign);
          scene.add(perimWallFB);
          collidableObjects.push(perimWallFB);
  
          sign = -1; // Swap to negative value
      }
  }

  
  
  // Update the camera and renderer when the window changes size
  function onWindowResize() {
  
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
  
    renderer.setSize(window.innerWidth, window.innerHeight);
  
  }
  
  function animate() {
    render();
    requestAnimationFrame(animate);
    // Get the change in time between frames
    var delta = clock.getDelta();
    animatePlayer(delta);
  }
  
  // Render the scene
  function render() {
    renderer.render(scene, camera);
  }
  
  // Converts degrees to radians
  function degreesToRadians(degrees) {
    return degrees * Math.PI / 180;
  }
  
  // Converts radians to degrees
  function radiansToDegrees(radians) {
    return radians * 180 / Math.PI;
  }

  function listenForPlayerMovement() {
    //콘트롤이 허락되었을 때만 작동
    
    // A key has been pressed
    var onKeyDown = function(event) {

    switch (event.keyCode) {

      case 38: // up
      case 87: // w
        moveForward = true;
        break;

      case 37: // left
      case 65: // a
        moveLeft = true;
        break;

      case 40: // down
      case 83: // s
        moveBackward = true;
        break;

      case 39: // right
      case 68: // d
        moveRight = true;
        break;
    }
  };

  // A key has been released
    var onKeyUp = function(event) {

    switch (event.keyCode) {

      case 38: // up
      case 87: // w
        moveForward = false;
        break;

      case 37: // left
      case 65: // a
        moveLeft = false;
        break;

      case 40: // down
      case 83: // s
        moveBackward = false;
        break;

      case 39: // right
      case 68: // d
        moveRight = false;
        break;
    }
  };

  // Add event listeners for when movement keys are pressed and released
  document.addEventListener('keydown', onKeyDown, false);
  document.addEventListener('keyup', onKeyUp, false);
}

 //충돌 감지 함수
 function detectPlayerCollision() {
    // The rotation matrix to apply to our direction vector
    // Undefined by default to indicate ray should coming from front
    var rotationMatrix;
    // Get direction of camera
    var cameraDirection = controls.getDirection(new THREE.Vector3(0, 0, 0)).clone();

    // Check which direction we're moving (not looking)
    // Flip matrix to that direction so that we can reposition the ray
    if (moveBackward) {
        rotationMatrix = new THREE.Matrix4();
        rotationMatrix.makeRotationY(degreesToRadians(180));
    }
    else if (moveLeft) {
        rotationMatrix = new THREE.Matrix4();
        rotationMatrix.makeRotationY(degreesToRadians(90));
    }
    else if (moveRight) {
        rotationMatrix = new THREE.Matrix4();
        rotationMatrix.makeRotationY(degreesToRadians(270));
    }

    // Player is not moving forward, apply rotation matrix needed
    if (rotationMatrix !== undefined) {
        cameraDirection.applyMatrix4(rotationMatrix);
    }

    // Apply ray to player camera
    var rayCaster = new THREE.Raycaster(controls.getObject().position, cameraDirection);

    // If our ray hit a collidable object, return true
    if (rayIntersect(rayCaster, PLAYERCOLLISIONDISTANCE)) {
        return true;
    } else {
        return false;
    }
}

function rayIntersect(ray, distance) {
    var intersects = ray.intersectObjects(collidableObjects);
    for (var i = 0; i < intersects.length; i++) {
        // Check if there's a collision
        if (intersects[i].distance < distance) {
            return true;
        }
    }
    return false;
}

function animatePlayer(delta) {
    // Gradual slowdown
    playerVelocity.x -= playerVelocity.x * 10.0 * delta;
    playerVelocity.z -= playerVelocity.z * 10.0 * delta;

    // If no collision and a movement key is being pressed, apply movement velocity
    //콘트롤이 허락되었을 때만 움직임(controls.enabled == true)
    if (detectPlayerCollision() == false && controls.enabled == true) {
        if (moveForward) {
            playerVelocity.z -= PLAYERSPEED * delta;
        }
        if (moveBackward) {
            playerVelocity.z += PLAYERSPEED * delta;
        } 
        if (moveLeft) {
            playerVelocity.x -= PLAYERSPEED * delta;
        }
        if (moveRight) {
            playerVelocity.x += PLAYERSPEED * delta;
        }

        controls.getObject().translateX(playerVelocity.x * delta);
        controls.getObject().translateZ(playerVelocity.z * delta);
    } else {
        // Collision or no movement key being pressed. Stop movememnt
        playerVelocity.x = 0;
        playerVelocity.z = 0;
    }
}

