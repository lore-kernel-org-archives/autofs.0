From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Another (stupid) question: autofs vs nfs for
	automounting purposes
Date: Fri, 11 Jun 2004 22:11:24 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406112158100.3247@xena.cft.ca.us>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AE@frodo.avalon.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1B7C89B8DCB084C809A22D7FEB90B3841AE@frodo.avalon.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: autofs@linux.kernel.org

On Fri, 11 Jun 2004, Dimitry V. Ketov wrote:

> - Which reasons (besides simplicity) led developers to the autofs
> solution?
> - What's wrong with nfs for the same things?

autofs mounts any available filesystem on demand.  It is most widely used 
for NFS filesystems, but the distributed /etc/auto.misc  file shows a 
number of examples of non-NFS mounts: the version I have has examples for a 
zip drive, a CD and a floppy, as well as NFS to a foreign site.  Samba 
mounts can also be done.  (I think.)

All the quirks and foibles of NFS that you have to deal with when mounting 
manually or via fstab, equally have to be dealt with when you use autofs.  
Often it is hard to figure out whether NFS or the automounter is 
responsible for a particular unexpected behavior.  

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
