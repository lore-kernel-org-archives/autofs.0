From: Ian Kent <raven@themaw.net>
Subject: Re: autofs expire_indirect errors in syslog
Date: Mon, 24 Mar 2008 14:24:46 +0900
Message-ID: <1206336287.2993.4.camel@raven.themaw.net>
References: <66d392400803192215p36cc021bv6bfae3c09e173602@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <66d392400803192215p36cc021bv6bfae3c09e173602@mail.gmail.com>
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
To: Kamil Kisiel <kamil@kamilkisiel.net>
Cc: autofs@linux.kernel.org


On Wed, 2008-03-19 at 22:15 -0700, Kamil Kisiel wrote:
> I'm using autofs to mount some NFS shares, but occasionally some of
> the machines on the network get their syslog filling up with errors
> like this:

Version info, distribution and autofs?

> 
> Mar 19 21:11:05 <hostname> automount[6762]: expire_indirect: fstat
> failed: Bad file descriptor
> Mar 19 21:12:20 <hostname> automount[6762]: expire_indirect: fstat
> failed: Bad file descriptor
> Mar 19 21:13:35 <hostname> automount[6762]: expire_indirect: fstat
> failed: Bad file descriptor
> 
> Any suggestions as to why this might be, or steps to take to debug?
