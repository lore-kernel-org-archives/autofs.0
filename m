From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Strange autofs V4.0 problems
Date: Mon, 2 Feb 2004 15:30:26 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C7C7C062-55D7-11D8-B42C-000A95A011F0@qualcomm.com>
References: <401EB843.5000501@analog.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <401EB843.5000501@analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: alan.burke@analog.com
Cc: autofs@linux.kernel.org, Annie Mckeon <anne.bourgeois@analog.com>

On Feb 2, 2004, at 12:51 PM, Alan.Burke wrote:

> Can't connect to certain Network Appliances boxes.  No rhyme or reason.
> Both /net and /home directories fail on some Net Apps but not others. 
> The
> Net App boxes are exporting correctly. We can mount the netapps, just 
> not
> via autofs.
>
> Errors from the messages file...
>
> Jan 29 15:36:54 cfl27 automount[19457]: mount(nfs): nfs: mount failure 
> 820ntap:/vol/vol1 on /net/820ntap/vol/vol1
> Jan 29 15:36:54 cfl27 automount[19457]: failed to mount /net/820ntap
> Jan 29 15:36:54 cfl27 automount[19467]: >> mount: 820ntap:/vol/vol1 
> failed, reason given by server: Permission denied

The fact that you're seeing that in your logs shows that autofs is 
working fine.. your host tried to mount the directory and was denied by 
the server.  I'm seeing the exact same thing for some new linux boxes I 
just installed over the weekend and some of our NetApp filers, and 
we're seeing the same thing from some new Solaris hosts as well.

I'm wondering if there's some kind of name/ip caching bug on the 
netapps that caches a deny for a very long period if you try to mount 
before your netgroups/dns is updated with the new host information.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
