From: Ian Kent <raven@themaw.net>
Subject: Re: using --ghost with 'program' type maps
Date: Sun, 12 Apr 2009 22:20:07 +0800
Message-ID: <1239546007.23791.7.camel@zeus.themaw.net>
References: <200904061117.10949.tom.urlings@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200904061117.10949.tom.urlings@gmail.com>
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
To: Tom Urlings <tom.urlings@gmail.com>
Cc: autofs@linux.kernel.org

On Mon, 2009-04-06 at 11:17 +0200, Tom Urlings wrote:
> hi all,
> i have been using autofs for a long time now, using it to dynamically gather 
> multimedia mounts using aufs locally and across local network..
> however, ghosting is not supported for 'program' maps.. which makes sharing a 
> autofs mount a bit odd..
> 
> example:
> server:/srv/multimedia -> automounted locally on server
> : uses aufs locally to mount all multimedia type directories on local storage
> 
> client:/opt/multimedia -> automounted locally on client
> : uses aufs locally to mount all multimedia type directories on local storage 
> and on automounted samba shares (also on server)
> 
> when server automount is mounted on client, server:/srv/multimedia is mounted, 
> but (as spec'ed) ghosting is not performed, giving an empty directory..
> 
> looks like the lookup_ghost on client does nothing as there are no cached 
> entries from the mapfile (program) available.. same goes on 
> server:/srv/multimedia..
> 
> could this be easily integrated into the automount source?

Not really.
There would need to be a quite a lot done to re-structure program map
lookup module and re-factor the tokenizer from the file file map lookup
module. I really don't have time to devote to this atm.

> 
> i have been looking into it today, but it looks a bit quirky to just 
> copy/paste the lookup_file.c:lookup_read_map into 
> lookup_program.c:lookup_read_map (with all ancilliaries)..

There's a lot more to it than that.

> 
> idea is to have the program maps return a complete 'file' map when given no 
> key on the commandline, and to 're-use' the lookup_file.c:lookup_read_map 
> functionality in the lookup_program.c:lookup_read_map

That's been mentioned before and it should work but, by and large,
program maps don't usually know their list of keys.

Ian
