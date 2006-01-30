From: Jacob Bower <jab00@doc.ic.ac.uk>
Subject: Why does autofs require root permissions?
Date: Mon, 30 Jan 2006 01:34:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.63L.0601300132280.9601@medusa-s4.doc.ic.ac.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

I'm trying to figure out why administrative privileges are required for 
both the automount program and to access the kernel autofs interface. 
Perhaps I've missed something but I can't see the security hole caused 
by allowing non-root users (with suitable directory permissions) to 
set-up their own automount points?

If it is not a security risk, then it would be useful if this 
restriction could be removed to allow fun hacks with things like FUSE. 
For example, I would like to set things up so if I move into 
/home/myhome/sshfs/foo@bar/, I automatically get connected via sshfs to 
'foo' as user 'bar'. However this can only be done effectively if the 
automount process managing /home/me/sshfs is started by my user account. 
Otherwise there is no easy route to getting access to my ssh agent, 
allowing one-password-only logins (and even my X11 session so I can have 
a GUI to ask for the passwords etc...).

-- 
Jacob Bower <jab00@doc.ic.ac.uk>
Custom Computing Group  - http://cc.doc.ic.ac.uk/
Department of Computing - http://www.doc.ic.ac.uk/
Imperial College London - http://www.ic.ac.uk/
