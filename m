From: Robert Au <rau@lsil.com>
Subject: Re: consistent pathnames vs autofs
Date: Thu, 24 Feb 2005 18:24:25 -0800
Message-ID: <20050225022425.GE15050@vprau.lsil.com>
References: <200502192052.j1JKqiKs002944@calvin.labs.agilent.com>
	<Pine.LNX.4.61.0502231142400.30588@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502231142400.30588@simba.math.ucla.edu>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Wed, Feb 23, 2005 at 12:09:38PM -0800, Jim Carter wrote:
> Here at UCLA-Mathnet our homedirs are of the form /net/tupelo/h1/maint/jimc 
> (tupelo is the name of the server, and /h1 is what tupelo exports), and 
> this path is valid both on random hosts, which NFS mount tupelo:/h1, and on 
> tupelo itself (Linux kernel 2.4.20 or 2.6.8 depending on which server), 
> where autofs does a bind mount from /net/tupelo/h1 to the local /h1. 
> It's considered bad form to refer to /h1 explicitly in a script that may 
> someday run on a different machine.
> 
> As a substitute for Sun's host map, we emit on the fly an indirect map
> file with one line "*  tupelo:/&" whenever a new server is referred to in 
> the /net directory.  Thus the client can mount anything that the server is 
> willing to export, without having to enumerate that in advance.
> 
> Wouldn't it be nice if such a map file could be built up from macros within 
> autofs, without needing to be instantiated as a file and periodically 
> cleaned up?  So instead of doing (the internal equivalent of) 
>     automount /net/tupelo file /tmp/tmpmaps/tupelo 
> we would do
>     automount /net/tupelo macro "* -rw,nodev,etc ${SERVER}:/&" \
> 							-DSERVER=tupelo

I'm confused. Shouldn't

  automount /net program /etc/auto.net rw,nodev,...

do what you want? Have you reimplemented the program map (and
/etc/auto.net) outside of autofs?

-- 
Robert Au                     rau@lsil.com
