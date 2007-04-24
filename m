From: Jimmy Dorff <jdorff@phy.duke.edu>
Subject: FC6 automounter stops mounting NFS mounts
Date: Tue, 24 Apr 2007 10:54:40 -0400
Message-ID: <462E1A30.3090002@phy.duke.edu>
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

I have a number of FC6 workstations that intermittently have a problem 
with automount, where it simply stops mounting filesystems.  If you 
attempt to access a directory which automount would normally mount your 
command simply hangs.  The automount process is running and still writes 
logs from the "verbose" option, but the logs don't indicate any problem. 
  The logs just show the "mount still busy" messages from previously 
mounted filesystem(s).  On the NFS server I don't see any mount requests 
from the afflicted client.

To "fix" the problem, I simply restart automount via "service autofs 
restart" and everything works as expected.

We have been seeing this problem intermittently throughout our use of 
FC6.  I don't have any clue what makes it happen.  Any info on how I can 
prevent this or gather more debug info is welcomed!

Details:
automounter version 5.0.1-0.rc3.26 on Fedora 6
kernel: 2.6.20-1.2933.fc6 i686
started as:
"automount --timeout=60 --verbose"
reading mounts from a NIS map from CentOS NIS server(s)

Thanks,
Jimmy Dorff
