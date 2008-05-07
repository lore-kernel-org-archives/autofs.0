From: "P.V.Anthony" <pvantony@singnet.com.sg>
Subject: How to change the FSINFO for nfsd?
Date: Wed, 07 May 2008 22:37:32 +0800
Message-ID: <4821BEAC.4070802@singnet.com.sg>
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

Hi,

Currently a gentoo linux server is used as a nfs server for some Mac OS
X clients. These Mac OS X clients are doing video editing.

Currently the video are captured directly to the NFS mounts.

Here is the problem. The video files are broken into 2GB files. This
because the video editing software(Final Cut Pro) breaks the files into
2GB sizes. It does not seem that the Mac OS X is not doing the breaking
up of files. It is the video editing software.

Some commercial company found an interesting behaviour. All the Mac OS X
NFS server FSINFO response in which the max file size is set to 'FFFF
FFFF FFFF FFFF' (all '1's).

The link about the above information can be found at this link below.
Read towards the bottom of the link.
http://forums.creativecow.net/thread/8/975362

I really would like to know where to change in the NFS source code so
that the FSINFO response from the server in which the max file size is
set to 'FFFF FFFF FFFF FFFF' (all '1's).

P.V.Anthony
