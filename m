From: Tim Hockin <thockin@sun.com>
Subject: Re: RE: autofs scalability
Date: Wed, 3 Dec 2003 11:43:23 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031203194323.GB10772@sun.com>
References: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Wed, Dec 03, 2003 at 01:19:27PM -0600, Ogden, Aaron A. wrote:
> 'unnamed device' limit has been raised from 256 to 4096 in kernel 2.6,
> can anyone confirm this?  If this is the case the only barrier left to
> remove is the RPC port limitation of ~800 open ports.  If the
> connections were multiplexed such that all connections to a given server
> used the same port then 800 ports would stretch a lot farther than they
> do now...

We're investigating the 800 limit reasoning.  2.6.(last I looked) has not
removed the 256 limit, but has made it so that it CAN BE removed.  We hav a
prelim patch for that, which I wan tot rework, some, maybe.
