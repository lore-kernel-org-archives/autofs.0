From: "Kamil Kisiel" <kamil@kamilkisiel.net>
Subject: Re: autofs expire_indirect errors in syslog
Date: Sun, 23 Mar 2008 22:31:41 -0700
Message-ID: <66d392400803232231pcc78fe5g514976d8288b0383@mail.gmail.com>
References: <66d392400803192215p36cc021bv6bfae3c09e173602@mail.gmail.com>
	<1206336287.2993.4.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1206336287.2993.4.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Sun, Mar 23, 2008 at 10:24 PM, Ian Kent <raven@themaw.net> wrote:
>
>  On Wed, 2008-03-19 at 22:15 -0700, Kamil Kisiel wrote:
>  > I'm using autofs to mount some NFS shares, but occasionally some of
>  > the machines on the network get their syslog filling up with errors
>  > like this:
>
>  Version info, distribution and autofs?
>
>
>
>  >
>  > Mar 19 21:11:05 <hostname> automount[6762]: expire_indirect: fstat
>  > failed: Bad file descriptor
>  > Mar 19 21:12:20 <hostname> automount[6762]: expire_indirect: fstat
>  > failed: Bad file descriptor
>  > Mar 19 21:13:35 <hostname> automount[6762]: expire_indirect: fstat
>  > failed: Bad file descriptor
>  >
>  > Any suggestions as to why this might be, or steps to take to debug?
>
>

I'm using kernel 2.6.24 for x86_64 on an AMD 64 and autofs version
5.0.3. The distribution is Gentoo Linux. This behavior is not isolated
to one machine, all of the machines running the same system image
exhibit the same symptoms every now and then.



-- 
Kamil
