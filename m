From: Jouni Laakso <jounijl@yahoo.co.uk>
Subject: Using automount with encrypted filesystems
Date: Sun, 31 Oct 2004 16:40:48 +0200
Message-ID: <200410311640.49389.jounijl@yahoo.co.uk>
Reply-To: jounijl@yahoo.co.uk
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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


Hello,

Question about mounting encrypted filesystems with automount.

I tried mounting encrypted filesystem with autofs (Suse 9.1) and it almost 
succeeded, only thing was that password prompt appeared in console that 
started the daemon from /etc/init.d/autofs without beeing able to write in 
the password. 

Is it possible to add something to the code, to a section just before when 
mount is going to be done for encrypted filesystems? Has it been done 
allready? Where can I find the solution?

Is there a way, a 'hook' or similar for example in automountd, to be able to 
pop up a window somehow to ask password when mounting encrypted filesystem or 
to redirect the password question to console screen for user to type it in or 
to handle encrypted filesystems mounting somehow securely and provide 
password etc. for mount when it is needed?

I think that access lists etc. can prohibit the use of mounted filesystem for 
others. I'm not sure. Is it possible to mount filesystem to be used by only 
one user?

Encrypted filesystems work with loopback device, howtos and examples can be 
found from www.tldp.org. 

Best regards,

Jouni
