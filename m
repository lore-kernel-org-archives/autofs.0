From: Stef Bon <stef@bononline.nl>
Subject: possible to differ the timeout per key?
Date: Fri, 01 Oct 2010 20:43:15 +0200
Message-ID: <4CA62BC3.7060301@bononline.nl>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

  Hello,

I'm building a construction to provide easy and effective access to 
different
resources like harddrives, usb sticks, cdroms and remote like smb shares.

It uses a very simple map:

*                -fstype=md5key :/&

and the key is a md5sum of a record.

The filesystem md5key does not exist of course but is a wrapper which 
calls the right mount command,
depending on the md5sum of the record. It will lookup the record, check 
what kind of resource it is and will call the right mount.command.

Now the timeout is set for all the mounts (smb shares, usb devices, 
harddrives, cdroms) the same (5 seconds) , but can I make this timeout 
differ per key/mountpoint??

Stef
