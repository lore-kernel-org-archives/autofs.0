From: =?ISO-8859-2?Q?Ji=F8=ED_=C8ervenka?= <cervenka@sps-pi.cz>
Subject: How to set more than one mountmaps for one mountpoint?
Date: Thu, 03 Aug 2006 10:03:57 +0200
Message-ID: <44D1ADED.9030706@sps-pi.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Hello,
I=B4m trying to automatically mount homedirectories that are stored on =

w2k3 server using autofs.Homedirectories are exported using SFU and NFS =

server.
Directory structure looks like this:

g:\class1\user1\
g:\class1\user2\
g:\class2\user3\
etc.

All user=B4s homedirectories are on linux stations stored in /home/user1/ =

and this is why I need to define more mountmaps for one mountpoint.
I tried several different configuration that should make this possible =

but with no success.
So my question is:
Is there a way how to set more mountmaps for one mountpoint?
Or is there a way how to make autofs to search all subdirectories in =

defined directory to find user=B4s homedir?
Thank you for help.
