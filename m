From: Ian Kent <raven@themaw.net>
Subject: Re: Help with ldap + autofs please
Date: Fri, 26 Mar 2004 10:41:23 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403261038460.4218@wombat.indigo.net.au>
References: <200403181118.34039.ndbecker2@verizon.net>
	<Pine.LNX.4.58.0403260835520.2053@wombat.indigo.net.au>
	<200403252114.40984.ndbecker2@verizon.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403252114.40984.ndbecker2@verizon.net>
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
To: Neal Becker <ndbecker2@verizon.net>
Cc: autofs@linux.kernel.org

On Thu, 25 Mar 2004, Neal Becker wrote:

> On Thursday 25 March 2004 07:36 pm, Ian Kent wrote:
> > On Thu, 25 Mar 2004, Neal Becker wrote:
> > > > /test	ldap:rpppc1.md.hns.com:nisMapName=auto.test,dc=adg,dc=hns,dc=com
> > > >
> > > > should work.
> > >
> > > This one is working:
> > > /test	ldap://rpppc1.md.hns.com/nisMapName=auto.test,dc=adg,dc=hns,dc=com
> >
> > Does that mean we need to review the patch that should allow the colon
> > syntax?
> 
> Not sure what you mean by "review the patch", but I don't personally care 
> which syntax is used.  The problem I found was it was really hard to find 
> anywhere that the correct syntax was documented.  A simple example would have 
> saved me a lot of time.
>


Cool. I'll include an example in 4.1.2.

automount(8) does describe the format of the server and dn but what the 
master map entry should be is not clear. 
