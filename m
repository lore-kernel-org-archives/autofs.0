From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Bug#316378: autofs: Deadlock causes automount failure
Date: Fri, 30 Jun 2006 00:17:19 +0200
Message-ID: <20060629221719.GA6280@uio.no>
References: <CECD6E8A589E8447BC6E836C8369AFF509D14A1A@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF509D14A1A@us-email.terastack.bluearc.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Dorey <mdorey@bluearc.com>, 316378@bugs.debian.org
Cc: autofs@linux.kernel.org

[sorry about the bottom-posting]

On Thu, Jun 29, 2006 at 02:45:32PM -0700, Martin Dorey wrote:
> martin>> Ian Kent suggests disabling the autofs locking, providing that
> martin>> mount locks mtab properly.  Does Debian's mount do that?
> 
> steinar> strace seems to indicate that it does: 
> 
> Cool.  I have *no* idea what I'm doing here but...
> 
> martind@duezer:/tmp$ apt-get source autofs
> martind@duezer:/tmp$ cd autofs-4.1.4
> martind@duezer:/tmp/autofs-4.1.4$ wget -O
> debian/patches/080_configurable_locking
> http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-configure
> able-locking.patch
> 
> ... and applying this patch...
> 
> martind@duezer:/tmp$ diff -u clean/autofs-4.1.4/debian/rules
> autofs-4.1.4/debian/
> --- clean/autofs-4.1.4/debian/rules	2006-06-29 14:40:28.000000000
> -0700
> +++ autofs-4.1.4/debian/rules	2006-06-29 14:29:17.000000000 -0700
> @@ -30,7 +30,7 @@
>  	dh_testdir
>  	(cd $(BUILD_DIR) && \
>  	    ./configure --prefix=/usr --mandir=/usr/share/man \
> -		--host=$(DEB_HOST_GNU_TYPE)
> --build=$(DEB_BUILD_GNU_TYPE) )
> +		--host=$(DEB_HOST_GNU_TYPE)
> --build=$(DEB_BUILD_GNU_TYPE) --disable-mount-locking)
>  	touch $@
>  
>  source.make: $(STAMP_DIR)/source.make
> martind@duezer:/tmp$
> 
> ... gave me something I could sudo dpkg-buildpackage; sudo dpkg -i
> ../autofs_4.1.4-10_i386.deb and which then solved my problem.

Interesting. Ian, is this something that's feasible to enable for Debian,
given that our mount seems to be locking mtab by itself?

/* Steinar */
-- 
Homepage: http://www.sesse.net/
