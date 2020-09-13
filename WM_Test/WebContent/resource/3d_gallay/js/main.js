
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
  [1, 1, 3, 1, 3, 1, 3, 1, 3, 1, 1, 1, ],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, ],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, ],
  [1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, ],
  [1, 0, 3, 5, 1, 5, 1, 5, 1, 1, 0, 1, ],
  [4, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, ],
  [1, 0, 0, 6, 1, 0, 3, 3, 3, 3, 0, 1, ],
  [4, 0, 0, 1, 1, 4, 0, 0, 0, 0, 0, 1, ],
  [1, 0, 0, 6, 1, 4, 0, 0, 0, 0, 0, 1, ],
  [4, 0, 0, 1, 1, 4, 0, 0, 0, 0, 0, 1, ],
  [1, 0, 0, 1, 1, 1, 5, 5, 5, 5, 5, 1, ],
  [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ]
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

  // Add the camera to the controller, then add to the scene
  controls = new THREE.PointerLockControls(camera);
  //카메라의 위치를 조정한다.
  //카메라의 z축
  controls.getObject().position.z = 400;
  //카메라의 높이
  controls.getObject().position.y = 45;

  controls.getObject().position.x = -400;
  
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
  const color = 0xFFFFFF;
  const intensity = 0.2;
  const light = new THREE.AmbientLight(color, intensity);
  scene.add(light);
}

//맵을 만드는데 사용될 벽을 만드는 함수
function createMazeWalls(gallay_num) {
  //텍스처 변수
  var texture;
  //벽을 만드는데 사용될 재료(텍스처를 담을 변수)
  var wallMaterial;
  //액자 및 그림 배열 변수 선언(렌덤하게 돌리기 위해 배열로 생성한다.)
  //정면(액자, 그림)
  var frameGeoFrontArr = [];
  var frameMaterialFrontArr = [];
  var paintingGeoFrontArr = [];
  var paintingMaterialFrontArr = [];

  //옆면(액자, 그림)
  var frameGeoSideArr = [];
  var frameMaterialSideArr = [];
  var paintingGeoSideArr = [];
  var paintingMaterialSideArr = [];

  //1번 전시관 이라면
  if (gallay_num == 1) {
    var map = gallay1;

    // 일반벽
    var wallGeo = new THREE.BoxBufferGeometry(UNITWIDTH, UNITHEIGHT, UNITWIDTH);

    //벽 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/wall_texture9.jpg');
    wallMaterial = new THREE.MeshPhongMaterial({
      map: texture,
    });

    //액자(정면)
    var frameGeoFront = new THREE.BoxGeometry(UNITWIDTH / 4 + 15, UNITHEIGHT / 6, 2);
    //배열에 삽입
    frameGeoFrontArr[0] = frameGeoFront;
    //액자(정면) 텍스처 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame3.png');
    var frameMaterialFront = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialFrontArr[0] = frameMaterialFront;

    //액자(옆면)
    var frameGeoSide = new THREE.BoxGeometry(2, UNITHEIGHT / 6, UNITWIDTH / 4 + 15);
    //배열에 삽입
    frameGeoSideArr[0] = frameGeoSide;
    //엑자(옆면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame3.png');
    var frameMaterialSide = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialSideArr[0] = frameMaterialSide;

    //그림(정면)
    var paintingGeoFront = new THREE.BoxGeometry(UNITWIDTH / 4 + 5, UNITHEIGHT / 6 - 8, 1);
    //배열에 삽입
    paintingGeoFrontArr[0] = paintingGeoFront;
    //그림(정면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg1.png');
    var paintingMaterialFront = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialFrontArr[0] = paintingMaterialFront;

    //그림(옆면)
    var paintingGeoSide = new THREE.BoxGeometry(1, UNITHEIGHT / 6 - 8, UNITWIDTH / 4 + 5);
    //배열에 삽입
    paintingGeoSideArr[0] = paintingGeoSide;

    //벽 텍스쳐 추가(**추가부분**)
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg2.jpeg');
    var paintingMaterialSide = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialSideArr[0] = paintingMaterialSide;

    //액자2(정면)
    var frameGeoFront2 = new THREE.BoxGeometry(UNITWIDTH / 4 + 15, UNITHEIGHT / 4, 2);
    //배열에 삽입
    frameGeoFrontArr[1] = frameGeoFront2;
    //엑자2(정면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame4.jpg');
    var frameMaterialFront2 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialFrontArr[1] = frameMaterialFront2;

    //액자2(옆면)
    var frameGeoSide2 = new THREE.BoxGeometry(2, UNITHEIGHT / 4, UNITWIDTH / 4 + 15);
    //배열에 삽입
    frameGeoSideArr[1] = frameGeoSide2;
    //엑자2(옆면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame4.jpg');
    var frameMaterialSide2 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialSideArr[1] = frameMaterialSide2;

    //그림2(정면)
    var paintingGeoFront2 = new THREE.BoxGeometry(UNITWIDTH / 4 + 8, UNITHEIGHT / 6 + 6, 1);
    //배열에 삽입
    paintingGeoFrontArr[1] = paintingGeoFront2;
    //그림2(정면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg3.jpg');
    var paintingMaterialFront2 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialFrontArr[1] = paintingMaterialFront2;

    //그림2(옆면)
    var paintingGeoSide2 = new THREE.BoxGeometry(1, UNITHEIGHT / 6 + 6, UNITWIDTH / 4 + 8);
    //배열에 삽입
    paintingGeoSideArr[1] = paintingGeoSide2;
    //그림2(옆면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg4.jpeg');
    var paintingMaterialSide2 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialSideArr[1] = paintingMaterialSide2;

    //액자3(정면)
    var frameGeoFront3 = new THREE.BoxGeometry(UNITWIDTH / 4 + 20, UNITHEIGHT / 4 + 15, 2);
    //배열에 삽입
    frameGeoFrontArr[2] = frameGeoFront3;
    //엑자3(정면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame5.jpg');
    var frameMaterialFront3 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialFrontArr[2] = frameMaterialFront3;

    //액자3(옆면)
    var frameGeoSide3 = new THREE.BoxGeometry(2, UNITHEIGHT / 4 + 15, UNITWIDTH / 4 + 20);
    //배열에 삽입
    frameGeoSideArr[2] = frameGeoSide3;
    //엑자3(옆면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/photoFrame5.jpg');
    var frameMaterialSide3 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    frameMaterialSideArr[2] = frameMaterialSide3;


    //그림3(정면)
    var paintingGeoFront3 = new THREE.BoxGeometry(UNITWIDTH / 4 + 10, UNITHEIGHT / 4 + 5, 1);
    //배열에 삽입
    paintingGeoFrontArr[2] = paintingGeoFront3;
    //그림3(정면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg3.jpg');
    var paintingMaterialFront3 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialFrontArr[2] = paintingMaterialFront;

    //그림3(옆면)
    var paintingGeoSide3 = new THREE.BoxGeometry(1, UNITHEIGHT / 4 + 5, UNITWIDTH / 4 + 10);
    //배열에 삽입
    paintingGeoSideArr[2] = paintingGeoSide3;
    //그림3(옆면) 텍스쳐 추가
    texture = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/testImg4.jpeg');
    var paintingMaterialSide3 = new THREE.MeshPhongMaterial({
      map: texture,
    });
    //배열에 삽입
    paintingMaterialSideArr[2] = paintingMaterialSide3;

    //텍스처를 반복해서 촘촘하게 출력되게 한다(중요)
    wallMaterial.map.repeat.x = 1;  //20번반복
    wallMaterial.map.repeat.y = 1;  //20번반복
    wallMaterial.map.wrapS = THREE.RepeatWrapping;
    wallMaterial.map.wrapT = THREE.RepeatWrapping;

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
      
      console.log(rNum);
      //일반벽(1)
      if (map[i][j] >= 1) {
        var pointLight;
        var color = 0xFFFFFF;
        var intensity = 2;

        var photoFrame;
        var photo;
        var wall = new THREE.Mesh(wallGeo, wallMaterial);
        wall.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
        wall.position.y = heightOffset;
        wall.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

        //랜덤수를 담을 변수(액자를 랜덤하게 출력하기위함)
        //0에서 배열 길이 만큼의 수를 생성
      var rNum = Math.floor( Math.random() *  frameGeoFrontArr.length);
        

        //전시벽(그림_앞쪽)(3)
        if (map[i][j] == 3) {
          // Make the cube
          photoFrame = new THREE.Mesh(frameGeoFrontArr[rNum], frameMaterialFrontArr[rNum]);
          photo = new THREE.Mesh(paintingGeoFrontArr[rNum], paintingMaterialFrontArr[rNum]);
          //조명 생성
          pointLight = new THREE.PointLight(color, intensity);
          
         


          photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset + 47;
          photoFrame.position.y = heightOffset - 30;
          photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

          photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset + 47.6;
          photo.position.y = heightOffset2 + 7.5;
          photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

          pointLight.position.set(photo.position.x, photo.position.y+5,  photo.position.z+20);
          

        }
        //전시벽(그림왼쪽)(4)
        if (map[i][j] == 4) {
          // Make the cube
          photoFrame = new THREE.Mesh(frameGeoSideArr[rNum], frameMaterialSideArr[rNum]);
          photo = new THREE.Mesh(paintingGeoSideArr[rNum], paintingMaterialSideArr[rNum]);

          //조명 생성
          pointLight = new THREE.PointLight(color, intensity);

          photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
          photoFrame.position.y = heightOffset - 30;
          photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset + 47;

          photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
          photo.position.y = heightOffset2 + 7.5;
          photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset + 47.6;

          pointLight.position.set(photo.position.x+20, photo.position.y+5,  photo.position.z);

        }
        //전시벽(그림_뒷쪽)(5)
        if (map[i][j] == 5) {
          // Make the cube
          photoFrame = new THREE.Mesh(frameGeoFrontArr[rNum], frameMaterialFrontArr[rNum]);
          photo = new THREE.Mesh(paintingGeoFrontArr[rNum], paintingMaterialFrontArr[rNum]);
           //조명 생성
           pointLight = new THREE.PointLight(color, intensity);
          

          photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset - 49;
          photoFrame.position.y = heightOffset - 30;
          photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

          photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset - 50;
          photo.position.y = heightOffset2 + 7.5;
          photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset;

          pointLight.position.set(photo.position.x, photo.position.y+5,  photo.position.z-20);

        }

        //전시벽(그림_오른쪽)(6)
        if (map[i][j] == 6) {
          photoFrame = new THREE.Mesh(frameGeoSideArr[rNum], frameMaterialSideArr[rNum]);
          photo = new THREE.Mesh(paintingGeoSideArr[rNum], paintingMaterialSideArr[rNum]);

          //조명 생성
          pointLight = new THREE.PointLight(color, intensity);

          photoFrame.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
          photoFrame.position.y = heightOffset - 30;
          photoFrame.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset - 45;

          photo.position.z = (i - totalCubesWide / 2) * UNITWIDTH + widthOffset;
          photo.position.y = heightOffset2 + 7.5;
          photo.position.x = (j - totalCubesWide / 2) * UNITWIDTH + widthOffset - 46;

          pointLight.position.set(photo.position.x-20, photo.position.y+5,  photo.position.z);

        }
        scene.add(wall);
        collidableObjects.push(wall);
        if (map[i][j] > 1) {
          pointLight.distance= 50;

          scene.add(photoFrame);
          scene.add(photo);
          scene.add(pointLight);

          collidableObjects.push(wall);
          collidableObjects.push(photoFrame);
          collidableObjects.push(photo);
        }

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
        textureDirt = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/gallay1_floor_texture3.jpeg');
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
    groundMat.map.repeat.x=10;  //20번반복
    groundMat.map.repeat.y=10;  //20번반복
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
    var textureDirt = THREE.ImageUtils.loadTexture('/resource/3d_gallay/images/gallay1_top_texture.jpg');

    
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

