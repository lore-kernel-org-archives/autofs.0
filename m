From: Stef Bon <stef@bononline.nl>
Subject: How to determine a path is a mountpoint.
Date: Mon, 15 Feb 2010 22:53:46 +0100
Message-ID: <201002152253.46863.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello,

I'm working on a construction of the automounter in combination with a fuse 
module.
The automounter is the mounthelper.
I'm looking for a way to determine in C a directory is a mountpoint, specially
a autofs managed directory, so a virtual directory created by the automounter.

I can parse the /etc/mtab file or /proc/mounts, like in bash:

cat /proc/mounts | grep --word-regexp "$mountpoint"

but this is slow.. I have looked to the code of the program mountpoint,
but this is not possible in an autofs maneged directory. This program
does a cd to the directory and checks the filesystem changes. With autofs this 
makes the mountpoint always mounted, which is of course not what I'm looking 
for.

Stef
