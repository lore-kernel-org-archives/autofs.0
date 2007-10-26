From: Massimo Mongardini <massimo@mongardini.it>
Subject: spurious 'executable not found' errors on nfs automounted
	partition
Date: Fri, 26 Oct 2007 12:59:54 +0100
Message-ID: <4721D6BA.5020003@mongardini.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi everyone,
    I am experiencing an issue in the following circumstances:

os: rhel4.5
kernel client: 2.6.9-55.0.9.ELsmp
kernel server: 2.6.9-55.0.2.ELsmp
autofs version 4.1.3-199.3

server exports folder /nfs/folder with parameters:
async,rw,fsid=1,no_root_squash

client automounts /nfs/folder with:

auto.master:
/nfs    /etc/auto.nfs

auto.nfs:
folder        -fstype=nfs,udp,rsize=32768,wsize=32768,noatime
fs-cluster:/nfs/folder

default values for automount are --timeout 60

If I run a script that checks with a series of increasing sleep
intervals < 120 if an exported file is executable,
I notice that if there is a coincidence between an unmount request and a
file request the file test fails

Thu Oct 25 17:00:28 GMT 2007 Error at DELAY: 38
Oct 25 17:00:28 server mountd[8014]: authenticated unmount request from
client:989 for /nfs/folder (/nfs/folder)
Fri Oct 26 04:48:41 GMT 2007 Error at DELAY: 25
Oct 26 04:48:41 server mountd[8014]: authenticated unmount request from
client:846 for /nfs/folder (/nfs/folder)

the test script looks like this:

EXECUTABLE="/nfs/folder/somepath/exec"
DELAY="1"
STOPCOUNT=120
OUT=$1
while true
do
 while [ "$DELAY" -lt "$STOPCOUNT" ]
  do
   test -x $EXECUTABLE
   if [ "$?" -ne "0" ]
    then
        echo "$(date) Error at DELAY: $DELAY" >> $OUT
    else
        echo "$(date) Executable found at DELAY: $DELAY" >> $OUT
   fi
   sleep $DELAY
  (( DELAY++ ))
 done
done

any help is much appreciated

cheers,
Massimo

-- 
Massimo Mongardini

_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_


echo 'Jg!J!hjwf!zpv!bo!bqqmf!boe!zpv!hjwf!nf!bo!bqqmf-!uifo!xf!xjmm!ibwf!bo!bqqmf!fbdi/!Cvu!jg!J!hjwf!zpv!bo!jefb!boe!zpv!hjwf!nf!bo!jefb-!xf!xjmm!ibwf!uxp!jefbt!fbdi!' | perl -pe 's/(.)/chr(ord($1)-1)/ge'


#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#--#

Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
