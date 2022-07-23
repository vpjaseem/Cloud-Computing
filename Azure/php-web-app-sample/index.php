 <!Doctype html>
<html>

<head>
     <title>HTML Application</title>
	 <link href="css/site.css" rel="stylesheet">
</head>

<body>
    <div class="main-container">
        <div class="cloud-image">
            <img src="img/successCloudNew.svg" />
        </div>
        <div class="content">
            <div class="tweet-container">
            <a href="https://www.linkedin.com/in/abdul-jaseem-ab1560114/">
                <img src="img/tweetThis.svg" />
            </a>            
        </div>
            <div class="content-body">
                <div class="success-text">Success!</div>
                <div class="description line-1"> Your Website is ready, HTML/PHP app is up and running!</div>
                
                <div class="next-steps-container">
                    <div class="next-steps-header">Next up</div>
                    <div class="next-steps-body">
                        <div class="step">
                            <div class="step-icon">
                                <img src="img/cloneWhite.svg">
                            </div>
                            <div class="step-text">Practice the task and get familiar with Web App Deployments</div>
                        </div>
                        <div class="step">
                            <div class="step-icon">
                                <img src="img/deployWhite.svg">
                            </div>
                            <div class="step-text"><a href="https://www.youtube.com/channel/UCgyu6yjUK_RCw6MgphtT-ig">More tutorials and videos on my YouTube channel</a></div>
                        </div>
                        <div class="step">
                            <div class="step-icon">
                                <img src="img/stackWhite.svg">
                            </div>
                            <div class="step-text">Connect me on <a href="https://www.linkedin.com/in/abdul-jaseem-ab1560114/">LinkedIn</a> | <a href="https://github.com/vpjaseem">GitHub</a></div>
                        </div>
                        <div class="step">
                            <div class="step-icon">
                                <img src="img/lightbulbWhite.svg">
                            </div>
                            <div class="step-text">This website runs on Local <?php $ip = $_SERVER['SERVER_ADDR']; echo "IP: $ip", "<br>";?>

</div>
                        

</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
