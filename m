From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time
Date: Mon, 17 Nov 2003 00:12:19 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311170006200.12952-100000@raven.themaw.net>
References: <3FB524E7.3090907@wildgate.miee.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB524E7.3090907@wildgate.miee.ru>
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
To: "Ruslan U. Zakirov" <cubic@wildgate.miee.ru>
Cc: autofs@linux.kernel.org, "Taylor, ForrestX" <forrestx.taylor@intel.com>

On Fri, 14 Nov 2003, Ruslan U. Zakirov wrote:

> Ian Kent wrote:
> >
> >Umm ...
> >
> >Beg to disagree.
> >
> >The autofs4-2.4 module build kit or the patches contained in it or the
> >patches contained in autofs-4.1.0-beta3 can give you this for some of the
> >maps. NIS, LDAP and file maps work at the moment.
> >
> >I's in the expected place on kernel.org.
> >	
> >  
> >
>         Hello, Ian and other.
> As I've understand you've implemented readdir relaited syscalls in 
> autofs for some map types, have you?

Basically, yes.

Some other related changes were also needed to make direct mount handling 
in the daemon simpiler (when working with the updated module).

> 
> If so then I hope that soon we could see programm maps with such 
> functionality.
> I want to do progamm map wich allow something more native representation 
> of windows workgroups like NetworkNigborhood. It would be very useful in 
> plain networks(like our ~900 PC in one workgroup).

But how do you know what the keys are?

In order to make mount points visible you need to know what they are. The 
definition of a program map is that it produces map entries as output 
given an input key.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
