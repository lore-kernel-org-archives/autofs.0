From: "Burke, Alan" <Alan.Burke@analog.com>
Subject: RE: Newbie needs help with automounter.
Date: Mon, 11 Oct 2004 14:25:08 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <8FDC0F9BE1F91D44BE964AA54AAA67B60E65E8B5@wilmexm3.ad.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@sun.com>, "William.Crocker" <william.crocker@analog.com>
Cc: autofs@linux.kernel.org

Hi 

I'm replying for Bill,

netstat -a --inet yields

Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address
State      
tcp        0      0 *:32768                 *:*
LISTEN      
tcp        0      0 *:7937                  *:*
LISTEN      
tcp        0      0 *:32769                 *:*
LISTEN      
tcp        0      0 *:login                 *:*
LISTEN      
tcp        0      0 *:7938                  *:*
LISTEN      
tcp        0      0 *:shell                 *:*
LISTEN      
tcp        0      0 *:684                   *:*
LISTEN      
tcp        0      0 *:finger                *:*
LISTEN      
tcp        0      0 *:sunrpc                *:*
LISTEN      
tcp        0      0 *:6000                  *:*
LISTEN      
tcp        0      0 *:ftp                   *:*
LISTEN      
tcp        0      0 *:22                    *:*
LISTEN      
tcp        0      0 *:631                   *:*
LISTEN      
tcp        0      0 *:telnet                *:*
LISTEN      
tcp        0      0 localhost.localdom:smtp *:*
LISTEN      
tcp        0      0 *:762                   *:*
LISTEN      
tcp        0      0 cfl30:902               ads601:sunrpc
TIME_WAIT   
tcp        0      0 cfl30:905               ads601:sunrpc
TIME_WAIT   
tcp        0      0 cfl30:906               ads601:32771
TIME_WAIT   
tcp        0      0 cfl30:903               ads601:32771
TIME_WAIT   
tcp        0     35 cfl30:login             chiapet:984
ESTABLISHED 
tcp        0      0 cfl30:906               ads601:32771
TIME_WAIT   
tcp        0      0 cfl30:907               ads601:32771
TIME_WAIT   
tcp        0      0 cfl30:903               ads601:32771
TIME_WAIT   
tcp        0     35 cfl30:login             chiapet:984
ESTABLISHED 
udp        0      0 *:128                   *:*

udp        0      0 *:256                   *:*

udp        0      0 *:384                   *:*

udp        0      0 *:biff                  *:*

udp        0      0 *:640                   *:*

udp        0      0 *:768                   *:*

udp        0      0 *:1                     *:*

udp        0      0 *:129                   *:*

udp        0      0 *:257                   *:*

udp        0      0 *:385                   *:*

udp        0      0 *:who                   *:*

udp        0      0 *:641                   *:*

udp        0      0 *:769                   *:*

udp        0      0 *:2049                  *:*

udp        0      0 *:32769                 *:*

udp        0      0 *:2                     *:*

udp        0      0 *:130                   *:*

udp        0      0 *:258                   *:*

udp        0      0 *:386                   *:*

udp        0      0 *:642                   *:*

udp        0      0 *:770                   *:*

udp        0      0 *:7938                  *:*

udp        0      0 *:syslog                *:*

udp        0      0 *:3                     *:*

udp        0      0 *:131                   *:*

udp        0      0 *:259                   *:*

udp        0      0 *:387                   *:*

udp        0      0 *:515                   *:*

udp        0      0 *:643                   *:*

udp        0      0 *:771                   *:*

udp        0      0 *:32771                 *:*

udp        0      0 *:4                     *:*

udp        0      0 *:132                   *:*

udp        0      0 *:260                   *:*

udp        0      0 *:388                   *:*

udp        0      0 *:516                   *:*

udp        0      0 *:644                   *:*

udp        0      0 *:772                   *:*

udp        0      0 *:32772                 *:*

udp        0      0 *:5                     *:*

udp        0      0 *:133                   *:*

udp        0      0 *:261                   *:*

udp        0      0 *:389                   *:*

udp        0      0 *:talk                  *:*

udp        0      0 *:645                   *:*

udp        0      0 *:773                   *:*

udp        0      0 *:32773                 *:*

udp        0      0 *:6                     *:*

udp        0      0 *:134                   *:*

udp        0      0 *:262                   *:*

udp        0      0 *:390                   *:*

udp        0      0 *:518                   *:*

udp        0      0 *:646                   *:*

udp        0      0 *:774                   *:*

udp        0      0 *:echo                  *:*

udp        0      0 *:135                   *:*

udp        0      0 *:263                   *:*

udp        0      0 *:391                   *:*

udp        0      0 *:519                   *:*

udp        0      0 *:647                   *:*

udp        0      0 *:775                   *:*

udp        0      0 *:8                     *:*

udp        0      0 *:136                   *:*

udp        0      0 *:264                   *:*

udp        0      0 *:392                   *:*

udp        0      0 *:route                 *:*

udp        0      0 *:648                   *:*

udp        0      0 *:776                   *:*

udp        0      0 *:discard               *:*

udp        0      0 *:137                   *:*

udp        0      0 *:265                   *:*

udp        0      0 *:393                   *:*

udp        0      0 *:521                   *:*

udp        0      0 *:649                   *:*

udp        0      0 *:777                   *:*

udp        0      0 *:10                    *:*

udp        0      0 *:138                   *:*

udp        0      0 *:266                   *:*

udp        0      0 *:394                   *:*

udp        0      0 *:522                   *:*

udp        0      0 *:650                   *:*

udp        0      0 *:778                   *:*

udp        0      0 *:11                    *:*

udp        0      0 *:139                   *:*

udp        0      0 *:267                   *:*

udp        0      0 *:395                   *:*

udp        0      0 *:523                   *:*

udp        0      0 *:651                   *:*

udp        0      0 *:779                   *:*

udp        0      0 *:12                    *:*

udp        0      0 *:140                   *:*

udp        0      0 *:268                   *:*

udp        0      0 *:396                   *:*

udp        0      0 *:524                   *:*

udp        0      0 *:652                   *:*

udp        0      0 *:780                   *:*

udp        0      0 *:daytime               *:*

udp        0      0 *:141                   *:*

udp        0      0 *:269                   *:*

udp        0      0 *:397                   *:*

udp        0      0 *:525                   *:*

udp        0      0 *:653                   *:*

udp        0      0 *:781                   *:*

udp        0      0 *:14                    *:*

udp        0      0 *:142                   *:*

udp        0      0 *:270                   *:*

udp        0      0 *:398                   *:*

udp        0      0 *:526                   *:*

udp        0      0 *:654                   *:*

udp        0      0 *:782                   *:*

udp        0      0 *:15                    *:*

udp        0      0 *:143                   *:*

udp        0      0 *:271                   *:*

udp        0      0 *:399                   *:*

udp        0      0 *:527                   *:*

udp        0      0 *:655                   *:*

udp        0      0 *:783                   *:*

udp        0      0 *:16                    *:*

udp        0      0 *:144                   *:*

udp        0      0 *:272                   *:*

udp        0      0 *:400                   *:*

udp        0      0 *:528                   *:*

udp        0      0 *:656                   *:*

udp        0      0 *:784                   *:*

udp        0      0 *:17                    *:*

udp        0      0 *:145                   *:*

udp        0      0 *:273                   *:*

udp        0      0 *:401                   *:*

udp        0      0 *:529                   *:*

udp        0      0 *:657                   *:*

udp        0      0 *:785                   *:*

udp        0      0 *:18                    *:*

udp        0      0 *:146                   *:*

udp        0      0 *:274                   *:*

udp        0      0 *:402                   *:*

udp        0      0 *:530                   *:*

udp        0      0 *:658                   *:*

udp        0      0 *:786                   *:*

udp        0      0 *:chargen               *:*

udp        0      0 *:147                   *:*

udp        0      0 *:275                   *:*

udp        0      0 *:403                   *:*

udp        0      0 *:531                   *:*

udp        0      0 *:659                   *:*

udp        0      0 *:787                   *:*

udp        0      0 *:20                    *:*

udp        0      0 *:148                   *:*

udp        0      0 *:276                   *:*

udp        0      0 *:404                   *:*

udp        0      0 *:532                   *:*

udp        0      0 *:660                   *:*

udp        0      0 *:788                   *:*

udp        0      0 *:21                    *:*

udp        0      0 *:149                   *:*

udp        0      0 *:277                   *:*

udp        0      0 *:405                   *:*

udp        0      0 *:533                   *:*

udp        0      0 *:661                   *:*

udp        0      0 *:789                   *:*

udp        0      0 *:22                    *:*

udp        0      0 *:150                   *:*

udp        0      0 *:278                   *:*

udp        0      0 *:406                   *:*

udp        0      0 *:534                   *:*

udp        0      0 *:662                   *:*

udp        0      0 *:790                   *:*

udp        0      0 *:23                    *:*

udp        0      0 *:151                   *:*

udp        0      0 *:279                   *:*

udp        0      0 *:407                   *:*

udp        0      0 *:535                   *:*

udp        0      0 *:663                   *:*

udp        0      0 *:791                   *:*

udp        0      0 *:24                    *:*

udp        0      0 *:152                   *:*

udp        0      0 *:280                   *:*

udp        0      0 *:408                   *:*

udp        0      0 *:536                   *:*

udp        0      0 *:664                   *:*

udp        0      0 *:792                   *:*

udp        0      0 *:25                    *:*

udp        0      0 *:153                   *:*

udp        0      0 *:281                   *:*

udp        0      0 *:409                   *:*

udp        0      0 *:537                   *:*

udp        0      0 *:665                   *:*

udp        0      0 *:793                   *:*

udp        0      0 *:26                    *:*

udp        0      0 *:154                   *:*

udp        0      0 *:282                   *:*

udp        0      0 *:410                   *:*

udp        0      0 *:538                   *:*

udp        0      0 *:666                   *:*

udp        0      0 *:794                   *:*

udp        0      0 *:27                    *:*

udp        0      0 *:155                   *:*

udp        0      0 *:283                   *:*

udp        0      0 *:411                   *:*

udp        0      0 *:539                   *:*

udp        0      0 *:667                   *:*

udp        0      0 *:795                   *:*

udp        0      0 *:28                    *:*

udp        0      0 *:156                   *:*

udp        0      0 *:284                   *:*

udp        0      0 *:412                   *:*

udp        0      0 *:540                   *:*

udp        0      0 *:668                   *:*

udp        0      0 *:796                   *:*

udp        0      0 *:29                    *:*

udp        0      0 *:157                   *:*

udp        0      0 *:285                   *:*

udp        0      0 *:413                   *:*

udp        0      0 *:541                   *:*

udp        0      0 *:669                   *:*

udp        0      0 *:797                   *:*

udp        0      0 *:30                    *:*

udp        0      0 *:158                   *:*

udp        0      0 *:286                   *:*

udp        0      0 *:414                   *:*

udp        0      0 *:542                   *:*

udp        0      0 *:670                   *:*

udp        0      0 *:798                   *:*

udp        0      0 *:31                    *:*

udp        0      0 *:159                   *:*

udp        0      0 *:799                   *:*

udp        0      0 *:287                   *:*

udp        0      0 *:415                   *:*

udp        0      0 *:543                   *:*

udp        0      0 *:671                   *:*

udp        0      0 *:416                   *:*

udp        0      0 *:800                   *:*

udp        0      0 *:32                    *:*

udp        0      0 *:160                   *:*

udp        0      0 *:288                   *:*

udp        0      0 *:544                   *:*

udp        0      0 *:672                   *:*

udp        0      0 *:33                    *:*

udp        0      0 *:161                   *:*

udp        0      0 *:289                   *:*

udp        0      0 *:417                   *:*

udp        0      0 *:545                   *:*

udp        0      0 *:673                   *:*

udp        0      0 *:418                   *:*

udp        0      0 *:34                    *:*

udp        0      0 *:162                   *:*

udp        0      0 *:290                   *:*

udp        0      0 *:546                   *:*

udp        0      0 *:674                   *:*

udp        0      0 *:35                    *:*

udp        0      0 *:163                   *:*

udp        0      0 *:291                   *:*

udp        0      0 *:419                   *:*

udp        0      0 *:547                   *:*

udp        0      0 *:675                   *:*

udp        0      0 *:36                    *:*

udp        0      0 *:164                   *:*

udp        0      0 *:292                   *:*

udp        0      0 *:420                   *:*

udp        0      0 *:548                   *:*

udp        0      0 *:676                   *:*

udp        0      0 *:time                  *:*

udp        0      0 *:165                   *:*

udp        0      0 *:293                   *:*

udp        0      0 *:421                   *:*

udp        0      0 *:549                   *:*

udp        0      0 *:677                   *:*

udp        0      0 *:38                    *:*

udp        0      0 *:166                   *:*

udp        0      0 *:294                   *:*

udp        0      0 *:422                   *:*

udp        0      0 *:new-rwho              *:*

udp        0      0 *:678                   *:*

udp        0      0 *:39                    *:*

udp        0      0 *:167                   *:*

udp        0      0 *:295                   *:*

udp        0      0 *:423                   *:*

udp        0      0 *:551                   *:*

udp        0      0 *:679                   *:*

udp        0      0 *:40                    *:*

udp        0      0 *:168                   *:*

udp        0      0 *:296                   *:*

udp        0      0 *:424                   *:*

udp        0      0 *:552                   *:*

udp        0      0 *:680                   *:*

udp        0      0 *:41                    *:*

udp        0      0 *:169                   *:*

udp        0      0 *:297                   *:*

udp        0      0 *:425                   *:*

udp        0      0 *:553                   *:*

udp        0      0 *:681                   *:*

udp        0      0 *:name                  *:*

udp        0      0 *:170                   *:*

udp        0      0 *:298                   *:*

udp        0      0 *:426                   *:*

udp        0      0 *:554                   *:*

udp        0      0 *:682                   *:*

udp        0      0 *:43                    *:*

udp        0      0 *:171                   *:*

udp        0      0 *:299                   *:*

udp        0      0 *:427                   *:*

udp        0      0 *:555                   *:*

udp        0      0 *:683                   *:*

udp        0      0 *:44                    *:*

udp        0      0 *:172                   *:*

udp        0      0 *:300                   *:*

udp        0      0 *:428                   *:*

udp        0      0 *:556                   *:*

udp        0      0 *:684                   *:*

udp        0      0 *:45                    *:*

udp        0      0 *:173                   *:*

udp        0      0 *:301                   *:*

udp        0      0 *:429                   *:*

udp        0      0 *:557                   *:*

udp        0      0 *:685                   *:*

udp        0      0 *:46                    *:*

udp        0      0 *:174                   *:*

udp        0      0 *:302                   *:*

udp        0      0 *:430                   *:*

udp        0      0 *:558                   *:*

udp        0      0 *:686                   *:*

udp        0      0 *:47                    *:*

udp        0      0 *:175                   *:*

udp        0      0 *:303                   *:*

udp        0      0 *:431                   *:*

udp        0      0 *:559                   *:*

udp        0      0 *:687                   *:*

udp        0      0 *:48                    *:*

udp        0      0 *:176                   *:*

udp        0      0 *:304                   *:*

udp        0      0 *:432                   *:*

udp        0      0 *:rmonitor              *:*

udp        0      0 *:688                   *:*

udp        0      0 *:945                   *:*

udp        0      0 *:49                    *:*

udp        0      0 *:305                   *:*

udp        0      0 *:433                   *:*

udp        0      0 *:monitor               *:*

udp        0      0 *:689                   *:*

udp        0      0 *:177                   *:*

udp        0      0 *:50                    *:*

udp        0      0 *:178                   *:*

udp        0      0 *:306                   *:*

udp        0      0 *:434                   *:*

udp        0      0 *:562                   *:*

udp        0      0 *:690                   *:*

udp        0      0 *:51                    *:*

udp        0      0 *:179                   *:*

udp        0      0 *:307                   *:*

udp        0      0 *:435                   *:*

udp        0      0 *:563                   *:*

udp        0      0 *:691                   *:*

udp        0      0 *:52                    *:*

udp        0      0 *:180                   *:*

udp        0      0 *:308                   *:*

udp        0      0 *:436                   *:*

udp        0      0 *:564                   *:*

udp        0      0 *:692                   *:*

udp        0      0 *:domain                *:*

udp        0      0 *:181                   *:*

udp        0      0 *:309                   *:*

udp        0      0 *:437                   *:*

udp        0      0 *:565                   *:*

udp        0      0 *:693                   *:*

udp        0      0 *:54                    *:*

udp        0      0 *:182                   *:*

udp        0      0 *:310                   *:*

udp        0      0 *:438                   *:*

udp        0      0 *:566                   *:*

udp        0      0 *:694                   *:*

udp        0      0 *:55                    *:*

udp        0      0 *:183                   *:*

udp        0      0 *:311                   *:*

udp        0      0 *:439                   *:*

udp        0      0 *:567                   *:*

udp        0      0 *:695                   *:*

udp        0      0 *:56                    *:*

udp        0      0 *:184                   *:*

udp        0      0 *:312                   *:*

udp        0      0 *:440                   *:*

udp        0      0 *:568                   *:*

udp        0      0 *:696                   *:*

udp        0      0 *:57                    *:*

udp        0      0 *:185                   *:*

udp        0      0 *:313                   *:*

udp        0      0 *:441                   *:*

udp        0      0 *:569                   *:*

udp        0      0 *:697                   *:*

udp        0      0 *:58                    *:*

udp        0      0 *:186                   *:*

udp        0      0 *:314                   *:*

udp        0      0 *:442                   *:*

udp        0      0 *:570                   *:*

udp        0      0 *:698                   *:*

udp        0      0 *:59                    *:*

udp        0      0 *:187                   *:*

udp        0      0 *:315                   *:*

udp        0      0 *:443                   *:*

udp        0      0 *:571                   *:*

udp        0      0 *:699                   *:*

udp        0      0 *:60                    *:*

udp        0      0 *:188                   *:*

udp        0      0 *:316                   *:*

udp        0      0 *:444                   *:*

udp        0      0 *:572                   *:*

udp        0      0 *:700                   *:*

udp        0      0 *:61                    *:*

udp        0      0 *:189                   *:*

udp        0      0 *:317                   *:*

udp        0      0 *:445                   *:*

udp        0      0 *:573                   *:*

udp        0      0 *:701                   *:*

udp        0      0 *:62                    *:*

udp        0      0 *:190                   *:*

udp        0      0 *:318                   *:*

udp        0      0 *:446                   *:*

udp        0      0 *:574                   *:*

udp        0      0 *:702                   *:*

udp        0      0 *:63                    *:*

udp        0      0 *:191                   *:*

udp        0      0 *:319                   *:*

udp        0      0 *:447                   *:*

udp        0      0 *:575                   *:*

udp        0      0 *:703                   *:*

udp        0      0 *:64                    *:*

udp        0      0 *:192                   *:*

udp        0      0 *:320                   *:*

udp        0      0 *:448                   *:*

udp        0      0 *:576                   *:*

udp        0      0 *:704                   *:*

udp        0      0 *:65                    *:*

udp        0      0 *:193                   *:*

udp        0      0 *:321                   *:*

udp        0      0 *:449                   *:*

udp        0      0 *:577                   *:*

udp        0      0 *:705                   *:*

udp        0      0 *:66                    *:*

udp        0      0 *:194                   *:*

udp        0      0 *:322                   *:*

udp        0      0 *:450                   *:*

udp        0      0 *:578                   *:*

udp        0      0 *:706                   *:*

udp        0      0 *:bootps                *:*

udp        0      0 *:195                   *:*

udp        0      0 *:323                   *:*

udp        0      0 *:451                   *:*

udp        0      0 *:579                   *:*

udp        0      0 *:707                   *:*

udp        0      0 *:bootpc                *:*

udp        0      0 *:196                   *:*

udp        0      0 *:324                   *:*

udp        0      0 *:452                   *:*

udp        0      0 *:580                   *:*

udp        0      0 *:708                   *:*

udp        0      0 *:tftp                  *:*

udp        0      0 *:197                   *:*

udp        0      0 *:325                   *:*

udp        0      0 *:453                   *:*

udp        0      0 *:581                   *:*

udp        0      0 *:709                   *:*

udp        0      0 *:70                    *:*

udp        0      0 *:198                   *:*

udp        0      0 *:326                   *:*

udp        0      0 *:454                   *:*

udp        0      0 *:582                   *:*

udp        0      0 *:710                   *:*

udp        0      0 *:71                    *:*

udp        0      0 *:199                   *:*

udp        0      0 *:327                   *:*

udp        0      0 *:455                   *:*

udp        0      0 *:583                   *:*

udp        0      0 *:711                   *:*

udp        0      0 *:72                    *:*

udp        0      0 *:200                   *:*

udp        0      0 *:328                   *:*

udp        0      0 *:456                   *:*

udp        0      0 *:584                   *:*

udp        0      0 *:712                   *:*

udp        0      0 *:73                    *:*

udp        0      0 *:201                   *:*

udp        0      0 *:329                   *:*

udp        0      0 *:457                   *:*

udp        0      0 *:585                   *:*

udp        0      0 *:713                   *:*

udp        0      0 *:74                    *:*

udp        0      0 *:202                   *:*

udp        0      0 *:330                   *:*

udp        0      0 *:458                   *:*

udp        0      0 *:586                   *:*

udp        0      0 *:714                   *:*

udp        0      0 *:75                    *:*

udp        0      0 *:203                   *:*

udp        0      0 *:331                   *:*

udp        0      0 *:459                   *:*

udp        0      0 *:587                   *:*

udp        0      0 *:715                   *:*

udp        0      0 *:76                    *:*

udp        0      0 *:204                   *:*

udp        0      0 *:332                   *:*

udp        0      0 *:460                   *:*

udp        0      0 *:588                   *:*

udp        0      0 *:716                   *:*

udp        0      0 *:77                    *:*

udp        0      0 *:205                   *:*

udp        0      0 *:333                   *:*

udp        0      0 *:461                   *:*

udp        0      0 *:589                   *:*

udp        0      0 *:717                   *:*

udp        0      0 *:78                    *:*

udp        0      0 *:206                   *:*

udp        0      0 *:334                   *:*

udp        0      0 *:462                   *:*

udp        0      0 *:590                   *:*

udp        0      0 *:718                   *:*

udp        0      0 *:79                    *:*

udp        0      0 *:207                   *:*

udp        0      0 *:335                   *:*

udp        0      0 *:463                   *:*

udp        0      0 *:591                   *:*

udp        0      0 *:719                   *:*

udp        0      0 *:80                    *:*

udp        0      0 *:208                   *:*

udp        0      0 *:336                   *:*

udp        0      0 *:464                   *:*

udp        0      0 *:592                   *:*

udp        0      0 *:720                   *:*

udp        0      0 *:81                    *:*

udp        0      0 *:209                   *:*

udp        0      0 *:337                   *:*

udp        0      0 *:465                   *:*

udp        0      0 *:593                   *:*

udp        0      0 *:721                   *:*

udp        0      0 *:82                    *:*

udp        0      0 *:210                   *:*

udp        0      0 *:338                   *:*

udp        0      0 *:466                   *:*

udp        0      0 *:594                   *:*

udp        0      0 *:722                   *:*

udp        0      0 *:83                    *:*

udp        0      0 *:211                   *:*

udp        0      0 *:339                   *:*

udp        0      0 *:467                   *:*

udp        0      0 *:595                   *:*

udp        0      0 *:723                   *:*

udp        0      0 *:84                    *:*

udp        0      0 *:212                   *:*

udp        0      0 *:340                   *:*

udp        0      0 *:468                   *:*

udp        0      0 *:596                   *:*

udp        0      0 *:724                   *:*

udp        0      0 *:85                    *:*

udp        0      0 *:213                   *:*

udp        0      0 *:341                   *:*

udp        0      0 *:469                   *:*

udp        0      0 *:597                   *:*

udp        0      0 *:725                   *:*

udp        0      0 *:86                    *:*

udp        0      0 *:214                   *:*

udp        0      0 *:342                   *:*

udp        0      0 *:470                   *:*

udp        0      0 *:598                   *:*

udp        0      0 *:726                   *:*

udp        0      0 *:87                    *:*

udp        0      0 *:215                   *:*

udp        0      0 *:343                   *:*

udp        0      0 *:471                   *:*

udp        0      0 *:599                   *:*

udp        0      0 *:727                   *:*

udp        0      0 *:88                    *:*

udp        0      0 *:216                   *:*

udp        0      0 *:344                   *:*

udp        0      0 *:472                   *:*

udp        0      0 *:600                   *:*

udp        0      0 *:728                   *:*

udp        0      0 *:89                    *:*

udp        0      0 *:217                   *:*

udp        0      0 *:345                   *:*

udp        0      0 *:473                   *:*

udp        0      0 *:601                   *:*

udp        0      0 *:729                   *:*

udp        0      0 *:90                    *:*

udp        0      0 *:218                   *:*

udp        0      0 *:346                   *:*

udp        0      0 *:474                   *:*

udp        0      0 *:602                   *:*

udp        0      0 *:730                   *:*

udp        0      0 *:91                    *:*

udp        0      0 *:219                   *:*

udp        0      0 *:347                   *:*

udp        0      0 *:475                   *:*

udp        0      0 *:603                   *:*

udp        0      0 *:731                   *:*

udp        0      0 *:92                    *:*

udp        0      0 *:220                   *:*

udp        0      0 *:348                   *:*

udp        0      0 *:476                   *:*

udp        0      0 *:604                   *:*

udp        0      0 *:732                   *:*

udp        0      0 *:93                    *:*

udp        0      0 *:221                   *:*

udp        0      0 *:349                   *:*

udp        0      0 *:477                   *:*

udp        0      0 *:605                   *:*

udp        0      0 *:733                   *:*

udp        0      0 *:94                    *:*

udp        0      0 *:222                   *:*

udp        0      0 *:350                   *:*

udp        0      0 *:478                   *:*

udp        0      0 *:606                   *:*

udp        0      0 *:734                   *:*

udp        0      0 *:95                    *:*

udp        0      0 *:223                   *:*

udp        0      0 *:351                   *:*

udp        0      0 *:479                   *:*

udp        0      0 *:607                   *:*

udp        0      0 *:735                   *:*

udp        0      0 *:96                    *:*

udp        0      0 *:224                   *:*

udp        0      0 *:352                   *:*

udp        0      0 *:480                   *:*

udp        0      0 *:608                   *:*

udp        0      0 *:736                   *:*

udp        0      0 *:97                    *:*

udp        0      0 *:225                   *:*

udp        0      0 *:353                   *:*

udp        0      0 *:481                   *:*

udp        0      0 *:609                   *:*

udp        0      0 *:737                   *:*

udp        0      0 *:98                    *:*

udp        0      0 *:226                   *:*

udp        0      0 *:354                   *:*

udp        0      0 *:738                   *:*

udp        0      0 *:482                   *:*

udp        0      0 *:610                   *:*

udp        0      0 *:99                    *:*

udp        0      0 *:227                   *:*

udp        0      0 *:355                   *:*

udp        0      0 *:739                   *:*

udp        0      0 *:483                   *:*

udp        0      0 *:611                   *:*

udp        0      0 *:100                   *:*

udp        0      0 *:228                   *:*

udp        0      0 *:356                   *:*

udp        0      0 *:484                   *:*

udp        0      0 *:612                   *:*

udp        0      0 *:740                   *:*

udp        0      0 *:101                   *:*

udp        0      0 *:229                   *:*

udp        0      0 *:357                   *:*

udp        0      0 *:485                   *:*

udp        0      0 *:613                   *:*

udp        0      0 *:741                   *:*

udp        0      0 *:102                   *:*

udp        0      0 *:230                   *:*

udp        0      0 *:358                   *:*

udp        0      0 *:742                   *:*

udp        0      0 *:486                   *:*

udp        0      0 *:614                   *:*

udp        0      0 *:103                   *:*

udp        0      0 *:231                   *:*

udp        0      0 *:359                   *:*

udp        0      0 *:487                   *:*

udp        0      0 *:615                   *:*

udp        0      0 *:743                   *:*

udp        0      0 *:104                   *:*

udp        0      0 *:232                   *:*

udp        0      0 *:360                   *:*

udp        0      0 *:488                   *:*

udp        0      0 *:616                   *:*

udp        0      0 *:744                   *:*

udp        0      0 *:105                   *:*

udp        0      0 *:233                   *:*

udp        0      0 *:361                   *:*

udp        0      0 *:489                   *:*

udp        0      0 *:617                   *:*

udp        0      0 *:745                   *:*

udp        0      0 *:106                   *:*

udp        0      0 *:234                   *:*

udp        0      0 *:362                   *:*

udp        0      0 *:490                   *:*

udp        0      0 *:618                   *:*

udp        0      0 *:746                   *:*

udp        0      0 *:107                   *:*

udp        0      0 *:235                   *:*

udp        0      0 *:363                   *:*

udp        0      0 *:491                   *:*

udp        0      0 *:619                   *:*

udp        0      0 *:747                   *:*

udp        0      0 *:108                   *:*

udp        0      0 *:236                   *:*

udp        0      0 *:364                   *:*

udp        0      0 *:492                   *:*

udp        0      0 *:620                   *:*

udp        0      0 *:748                   *:*

udp        0      0 *:109                   *:*

udp        0      0 *:237                   *:*

udp        0      0 *:365                   *:*

udp        0      0 *:621                   *:*

udp        0      0 *:493                   *:*

udp        0      0 *:749                   *:*

udp        0      0 *:110                   *:*

udp        0      0 *:238                   *:*

udp        0      0 *:366                   *:*

udp        0      0 *:622                   *:*

udp        0      0 *:494                   *:*

udp        0      0 *:750                   *:*

udp        0      0 *:239                   *:*

udp        0      0 *:367                   *:*

udp        0      0 *:495                   *:*

udp        0      0 *:623                   *:*

udp        0      0 *:751                   *:*

udp        0      0 *:sunrpc                *:*

udp        0      0 *:112                   *:*

udp        0      0 *:240                   *:*

udp        0      0 *:368                   *:*

udp        0      0 *:496                   *:*

udp        0      0 *:624                   *:*

udp        0      0 *:752                   *:*

udp        0      0 *:113                   *:*

udp        0      0 *:241                   *:*

udp        0      0 *:369                   *:*

udp        0      0 *:497                   *:*

udp        0      0 *:625                   *:*

udp        0      0 *:753                   *:*

udp        0      0 *:114                   *:*

udp        0      0 *:242                   *:*

udp        0      0 *:370                   *:*

udp        0      0 *:498                   *:*

udp        0      0 *:626                   *:*

udp        0      0 *:754                   *:*

udp        0      0 *:115                   *:*

udp        0      0 *:243                   *:*

udp        0      0 *:371                   *:*

udp        0      0 *:499                   *:*

udp        0      0 *:627                   *:*

udp        0      0 *:755                   *:*

udp        0      0 *:116                   *:*

udp        0      0 *:244                   *:*

udp        0      0 *:372                   *:*

udp        0      0 *:500                   *:*

udp        0      0 *:628                   *:*

udp        0      0 *:756                   *:*

udp        0      0 *:117                   *:*

udp        0      0 *:245                   *:*

udp        0      0 *:373                   *:*

udp        0      0 *:501                   *:*

udp        0      0 *:629                   *:*

udp        0      0 *:757                   *:*

udp        0      0 *:118                   *:*

udp        0      0 *:246                   *:*

udp        0      0 *:374                   *:*

udp        0      0 *:502                   *:*

udp        0      0 *:630                   *:*

udp        0      0 *:758                   *:*

udp        0      0 *:119                   *:*

udp        0      0 *:247                   *:*

udp        0      0 *:375                   *:*

udp        0      0 *:503                   *:*

udp        0      0 *:631                   *:*

udp        0      0 *:759                   *:*

udp        0      0 *:120                   *:*

udp        0      0 *:248                   *:*

udp        0      0 *:376                   *:*

udp        0      0 *:504                   *:*

udp        0      0 *:632                   *:*

udp        0      0 *:760                   *:*

udp        0      0 *:121                   *:*

udp        0      0 *:249                   *:*

udp        0      0 *:377                   *:*

udp        0      0 *:505                   *:*

udp        0      0 *:633                   *:*

udp        0      0 *:761                   *:*

udp        0      0 *:122                   *:*

udp        0      0 *:250                   *:*

udp        0      0 *:378                   *:*

udp        0      0 *:506                   *:*

udp        0      0 *:634                   *:*

udp        0      0 *:762                   *:*

udp        0      0 cfl30:ntp               *:*

udp        0      0 localhost.localdoma:ntp *:*

udp        0      0 *:ntp                   *:*

udp        0      0 *:251                   *:*

udp        0      0 *:379                   *:*

udp        0      0 *:507                   *:*

udp        0      0 *:635                   *:*

udp        0      0 *:763                   *:*

udp        0      0 *:124                   *:*

udp        0      0 *:252                   *:*

udp        0      0 *:380                   *:*

udp        0      0 *:508                   *:*

udp        0      0 *:636                   *:*

udp        0      0 *:764                   *:*

udp        0      0 *:125                   *:*

udp        0      0 *:253                   *:*

udp        0      0 *:381                   *:*

udp        0      0 *:509                   *:*

udp        0      0 *:637                   *:*

udp        0      0 *:765                   *:*

udp        0      0 *:126                   *:*

udp        0      0 *:254                   *:*

udp        0      0 *:382                   *:*

udp        0      0 *:510                   *:*

udp        0      0 *:638                   *:*

udp        0      0 *:766                   *:*

udp        0      0 *:127                   *:*

udp        0      0 *:255                   *:*

udp        0      0 *:383                   *:*

udp        0      0 *:511                   *:*

udp        0      0 *:639                   *:*

udp        0      0 *:767                   *:*



/proc/mounts too big to post all.

rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
/proc /proc proc rw 0 0
/dev/sda1 /boot ext3 rw 0 0
none /dev/pts devpts rw 0 0
/dev/sda5 /opt ext3 rw 0 0
none /dev/shm tmpfs rw 0 0
/dev/sda6 /tmp ext3 rw 0 0
/dev/sda3 /usr ext3 rw 0 0
/dev/sdb2 /var ext3 rw 0 0
/dev/sda7 /var1 ext3 rw 0 0
automount(pid599) /net autofs rw 0 0
automount(pid813) /home autofs rw 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
ds

Snip few hundred lines

nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
nfs
rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
dsdesign 0 0
novus:/novus/whc /home/whc nfs
rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=novus 0 0
dmv3:/disk1/rs /home/rsadmin nfs
rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=dmv3 0 0
automount(pid13414) /dcad autofs rw 0 0
automount(pid13293) /proj autofs rw 0 0
831ntap:/vol/vol0/proj/asic /proj/asic nfs
rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=831ntap 0 0
cadntap:/vol/vol0/disk0/apps /dcad/apps nfs
rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=cadntap 0 0
automount(pid31682) /misc autofs rw 0 0
automount(pid31710) /net autofs rw 0 0
automount(pid31743) /ajbhome autofs rw 0 0
automount(pid31775) /local autofs rw 0 0
automount(pid31836) /admin autofs rw 0 0
automount(pid31912) /proj autofs rw 0 0
automount(pid31832) /homes autofs rw 0 0
automount(pid31865) /site autofs rw 0 0
automount(pid31962) /home autofs rw 0 0
automount(pid31933) /ntap autofs rw 0 0
automount(pid32021) /dcad autofs rw 0 0
automount(pid32064) /cad autofs rw 0 0


-----Original Message-----
From: autofs-bounces@linux.kernel.org
[mailto:autofs-bounces@linux.kernel.org] On Behalf Of Mike Waychison
Sent: Monday, October 11, 2004 1:12 PM
To: William.Crocker
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Newbie needs help with automounter.

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William.Crocker wrote:
> Hello:
> 
> I am new to autofs/automounter and need help understanding
> the following messages which I found in /var/log/messages.
> 
> These messages appeared when I tried to
> change directory to /proj/asic on cfl30.
> 
> If I stop and then start autofs it will work for a while
> and then start failing again.
> 
> Thanks in advance.
> 
> Bill
> 
> ------------- /var/log/messages -------------
> 
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than
kernel
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 automount[14622]: >> mount: wrong fs type, bad
option, bad superblock on 831ntap:/vol/vol0/proj/asic,
> Oct  9 18:30:31 cfl30 automount[14622]: >>        or too many mounted
file systems
> Oct  9 18:30:31 cfl30 automount[14622]: mount(nfs): nfs: mount failure
831ntap:/vol/vol0/proj/asic on /proj/asic
> Oct  9 18:30:31 cfl30 automount[14622]: failed to mount /proj/asic
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than
kernel
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 automount[14624]: >> mount: wrong fs type, bad
option, bad superblock on 831ntap:/vol/vol0/proj/asic,
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 automount[14624]: >>        or too many mounted
file systems
> Oct  9 18:30:31 cfl30 automount[14624]: mount(nfs): nfs: mount failure
831ntap:/vol/vol0/proj/asic on /proj/asic
> Oct  9 18:30:31 cfl30 automount[14624]: failed to mount /proj/asic
> 

This occurs when the kernel can't bind to a reserved port (<1024) when
building the rpc transport.  In fact, the rpc code further limits the
available ports to 1-800.   You can try upping the value of
XPRT_MAX_RESVPORT in net/sunrpc/xprt.c to 1024, or higher if your nfs
servers don't care what port the client is connecting from.

This said, this is likely a symptom of one of two things:

- - You are mounting hundreds of nfs filesystems (the current code does
not multiplex rpc connections at all).
- - Automounter ran wild and is mounting filesystems that are not
getting
freed/umounnted properly.

Can you post the output of 'cat /proc/mounts' and 'netstat -a --inet' as
well as versioning information for your kernel and automounter you are
using?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBar7NdQs4kOxk3/MRAmKVAKCbxhhMthZ+T2fLG9XZ4Y04+0V1gwCfQ6IQ
oBaXn6tijYWEgbArqoSTlG8=
=LBX8
-----END PGP SIGNATURE-----

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs
