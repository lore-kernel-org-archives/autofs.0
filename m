From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Automounter to dump maps
Date: Thu, 12 Nov 2009 18:08:05 +0100
Message-ID: <4AFC40F5.80909@s3group.cz>
References: <4AFC0BEB.3040808@s3group.cz> <4AFC212C.4010409@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AFC212C.4010409@themaw.net>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


> It's not a bad idea but I wonder how useful it really is since what is
> really useful in trying to sort out problems is the debug log output.
>
>   
I agree.  This was meant to be good for situations where you know that 
autofs works fine but say you have multiple ldap servers autofs can 
connect to and you are unsure whether all are properly synchronized. 
This way you can make sure that automounter sees the "proper" data 
immediately without having to read through the detailed debug log. Even 
with a single ldap server it is often annoying to parse the debug log 
just to make sure the data is correct.

> > Well, back in the autofs4 days, when way too much logic was put into the
> > init script, we basically had to do this.   ;-)   See the --dumpmap switch
> > in v4.  I can see that it could be a useful aid for administrators to
> > ensure that their maps look like they think they do, especially with
> > nsswitch and included maps, and those pesky null maps.


> Well, there you go.
> This sounds like a +1 in favour to me.



So can I hope something like the --dumpmap switch will be implemented 
even in v5? :-)

Many thanks,

Ondrej
