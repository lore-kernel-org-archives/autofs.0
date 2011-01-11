From: Ian Kent <ikent@redhat.com>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
 servers
Date: Tue, 11 Jan 2011 14:32:19 +0800
Message-ID: <1294727539.2975.9.camel@perseus>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>
	<4D2581F0.8020607@s3group.cz> <1294322864.2852.3.camel@perseus>
	<4D27115A.9010805@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4D27115A.9010805@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2011-01-07 at 14:12 +0100, Ondrej Valousek wrote:
> On 06.01.2011 15:07, Ian Kent wrote: 
> > Thanks for the suggestions.
> > I'm still on leave so things are still going slowly for now, but I'll
> > get to it.
> Hi Ian,
> 
> Please find the attached patch which fixes the problem for me.
> I also changed the "dclist" structure definition from:
> 
> struct dclist {
>         time_t expire;
>         const char *uri;
> };
> 
> into:
> 
> struct dclist {
>         time_t expire;
>         char **uri;
>         int cnt;
> };
> 
> Hope you'll find it useful :-) .

Sorry I didn't get onto this earlier.
I could have saved you quite a bit of time.

Now that I've had a look I see I've already worked on this problem.
See:
http://www.kernel.org/pub/linux/daemons/autofs/v5/autofs-5.0.5-check-each-dc-server.patch

Ian
