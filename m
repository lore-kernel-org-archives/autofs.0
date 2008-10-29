From: Ondrej Valousek <webserv@s3group.cz>
Subject: Read-only map
Date: Wed, 29 Oct 2008 16:08:35 +0100
Message-ID: <49087C73.6080502@s3group.cz>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi List,

I have a problem:
My system (client, server) RHEL 5.2, latest updates.
1. NFS server is exporting read/write share
2. NIS automount map point to that share, but in read only like "key -ro
nfsserver:/share/key"

Now, the "strange" thing is that on clients that share is mounted read
only, fine, but when I go to the nfsserver itself, the share is mounted
read write. I understand this is because mount --bind is used instead of
nfs for performance reasons, but this way we lose the -ro flag.
Is there any simple solution to this?
Thanks,


Ondrej
