From: Howard Wilkinson <howard@cohtech.com>
Subject: Problem with mount.nfs4 on latest Fedora 10 updates
Date: Thu, 13 Aug 2009 17:50:08 +0100
Message-ID: <4A844440.3030504@cohtech.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <nfsv4-bounces@linux-nfs.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux-nfs.org/cgi-bin/mailman/options/nfsv4>,
	<mailto:nfsv4-request@linux-nfs.org?subject=unsubscribe>
List-Archive: <http://linux-nfs.org/pipermail/nfsv4>
List-Post: <mailto:nfsv4@linux-nfs.org>
List-Help: <mailto:nfsv4-request@linux-nfs.org?subject=help>
List-Subscribe: <http://linux-nfs.org/cgi-bin/mailman/listinfo/nfsv4>,
	<mailto:nfsv4-request@linux-nfs.org?subject=subscribe>
Sender: nfsv4-bounces@linux-nfs.org
Errors-To: nfsv4-bounces@linux-nfs.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org, For users of Fedora Core releases <fedora-list@redhat.com>, nfsv4@linux-nfs.org

I have just upgraded a couple of servers from FC9 to FC10 and I am 
seeing a major problem with mount.nfs4. This occurs when autofs calls 
the mount program. It then runs at 100% CPU and never terminates.

I have VMs that are running similar configuration successfully, so this 
is something driven by being on bare metal.

Kernel is 2.6.27.29-170.2.78.fc10.i686.PAE
nfs-utils is nfs-utils-1.1.4-8.fc10.i386
autofs is autofs-5.0.3-41.i386

Command running is

/sbin/mount.nfs4 battleaxe:/ /hosts/battleaxe -s -o 
rw,nosuid,nodev,tcp,rsize=32768,wsize=32768,hard,intr

The autofs mount has worked and the directories under /hosts/battleaxe 
have been successfully accessed prior to the problem occuring - I 
suspect this is a remount after and expire has occurred.

Anybody seen this before?
Anybody know what I can do to get round this? [I am on the way to FC11 
but will have to live with FC10 for a while (a week or so)]
Any extra information I can acquire to diagnose this?

There is nothing in the log files to indicate anything going wrong, I 
could turn debug on if I knew what to set and which messages to strip 
once I do.

Any help appreciated. Howard.
