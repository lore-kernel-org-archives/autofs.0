From: David <spoel@xray.bmc.uu.se>
Subject: autofs not mounting from nis maps
Date: Wed, 16 Mar 2005 21:25:18 +0100
Message-ID: <1111004718.6120.16.camel@studio.bibu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi

I have a NIS server that broadcasts an auto.XXX files as such:

[root@appel2 proc]# ypcat -k auto.master
/home  auto.home
/usr/local  auto.local
/pub auto.pub

[root@appel2 proc]# ypcat -k auto.home | head -8
magnusa  hirst:/homes/hirst/dsk1/&
hattne   hirst:/homes/hirst/dsk2/&
maria  hirst:/homes/hirst/dsk2/&
diane  hirst:/homes/hirst/dsk2/&
alina dqs1:/user13/&
guestji hirst:/homes/hirst/dsk2/&
hanna hirst:/homes/hirst/dsk2/&
gunilla  bacon:/Users/&

...

On the client side roughly half of the directories are actually mounted
when I cd into them, the other half give:
[root@appel2 proc]# cd /home/magnusa
-bash: cd: /home/magnusa: No such file or directory

Without NIS everything works fine. However I have a few tens of
workstations so it's quite tedious to update all machines with new files
and restart autofs whenever something changes.

Am I doing something terribly wrong? Any other tips?

We are running debian on the servers and different Fedora's on the
clients.

-- 
David.
________________________________________________________________________
David van der Spoel, PhD, Assoc. Prof., Molecular Biophysics group,
Dept. of Cell and Molecular Biology, Uppsala University.
Husargatan 3, Box 596,          75124 Uppsala, Sweden
phone:  46 18 471 4205          fax: 46 18 511 755
spoel@xray.bmc.uu.se    spoel@gromacs.org   http://xray.bmc.uu.se/~spoel
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
