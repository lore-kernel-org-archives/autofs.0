From: Michael Loftis <mloftis@wgops.com>
Subject: Re: two /net paths to the same local mount?
Date: Mon, 21 Jun 2010 20:05:01 -0600
Message-ID: <35D166B0274C8DB77A6BE435@[192.168.1.100]>
References: <4C1FBABF.5060207@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4C1FBABF.5060207@oracle.com>
Content-Disposition: inline
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
To: Chris Quenelle <chris.quenelle@oracle.com>, autofs@linux.kernel.org

<reply inline>

--On Monday, June 21, 2010 12:17 PM -0700 Chris Quenelle 
<chris.quenelle@oracle.com> wrote:

> When I use /net/host and /net/host.domain to access a file system
> that is local to the current host, the second flavor of access will
> hang.

Check the /etc/hosts file on the machine having the problem.  Usually this 
means that your'e expecting it to contact from/to one address (say the 
loopback in the case of hostname) but the hosts file has another for the 
hostname.domain case, or doesn't have one, so it's getting the external 
address via DNS.

>
> We have a complex build environment running on multiple hosts,
> so directory names often need to work either locally or remotely.
> That's why we're using /net paths for the local host.
>
> Is this a known bug?
>
> I can supply more details, if necessary.
> Rebuilding from source is not really practical in my environment.
>
> --chris
>
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
