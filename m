From: "Jerzy Jalocha N" <jjalocha@gmail.com>
Subject: Re: basic SOHO NFS/autofs setup for noob help
Date: Wed, 2 Jan 2008 15:05:50 -0600
Message-ID: <9b72f9a90801021305x535e2c7ar5c91539b39e652dd@mail.gmail.com>
References: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9b72f9a90801021042m65d350ak5467b4c500d94933@mail.gmail.com>
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
To: autofs@linux.kernel.org

!!!! SOLVED !!!!

The following entry in '/etc/auto.shared' works correctly:
* -fstype=nfs,rw,sync,soft,intr,rsize=8192,wsize=8192 192.168.1.20:/shared/&

What I had wrong right before, was the IP address.

I had tested this configuration several times before, but since 'cd
/shared' and 'ls /shared' didn't show anything, I thought it wasn't
working. 'ls /shared/subdir' now works perfectly, and probably always
has!

Thank you so much, jeff and muzzol, for your help. You both provided
me the necessary pieces for making this work.

(I'll still read further, to understand it better.)
