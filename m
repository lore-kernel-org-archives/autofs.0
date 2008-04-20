From: Ian Kent <raven@themaw.net>
Subject: Re: wait_for_lock() in mount
Date: Sun, 20 Apr 2008 22:50:47 +0800
Message-ID: <1208703048.3632.8.camel@raven.themaw.net>
References: <3307cdf90804180939t42fed2d7k8fc96304f8d01455@mail.gmail.com>
	<1208576146.3090.5.camel@raven.themaw.net>
	<3307cdf90804191052v194cc2bctb25b6aab612e903d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3307cdf90804191052v194cc2bctb25b6aab612e903d@mail.gmail.com>
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
To: Rajouri Jammu <rajouri.jammu@gmail.com>
Cc: autofs@linux.kernel.org


On Sat, 2008-04-19 at 10:52 -0700, Rajouri Jammu wrote:
> Thank you for the prompt response.
> 
> 
> Yes, I'm using autofs4 which came with CentOS release 4.6 

RHEL-4 U6 should be OK.
But I don't think any of the versions of mount are 100%.

> 
> 
> mount -V
> mount: mount-2.12a
> 
> 
> 
> Is that version of mount OK or do I need a newer version to work with
> the locking path?
> If I need a newer version can you please let me know approximately
> which one?
> 
> 
> Lastly, does autofs5 not have this issue?

This is a problem with mount and any version of autofs that
uses /etc/mtab will have this problem.

The later revisions of autofs v4 and autofs v5 use /etc/mtab somewhat
less and so are less vulnerable.

Using the patch requires a configure option to be specified.
I'm not sure if this patch has been added to the RHEL-4 package, you'll
need to check. In RHEL-5 the configure option is used when the package
is built so CentOS 5 will have this already.

Ian
