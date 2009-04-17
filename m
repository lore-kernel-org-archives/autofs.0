From: Stef Bon <stef@bononline.nl>
Subject: hal and autofs
Date: Fri, 17 Apr 2009 11:33:37 +0200
Message-ID: <49E84CF1.6090004@bononline.nl>
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

Hello,

I've created a construction which mounts local devices like USB sticks 
and remote (network) services in a connectionsmap in the users 
homedirectory.

Integration with my desktop  (KDE 4.2) is not that good. When in 
Dolphin, it tries to mount the devices at /media, not in this autofs 
managed directory (in my case /home/sbon/Connections/Devices). 
Responsible for this behaviour in KDE is HAL.

Integration of autofs and hal is imho a good idea. It should be an 
configurationoption to let the automounter handle the mounting, or do it 
the way things are done at this moment (by HAL).

Required is that autofs has dbus support. I do not have a lot of 
experience with dbus, but other systems should be able to add a 
mountpoint (with all options and the path to the local device), and 
autofs should export information about all mountpoints it manages, and 
which devices are mounted or not.

What's your opinion, is this possible?

Stef Bon
