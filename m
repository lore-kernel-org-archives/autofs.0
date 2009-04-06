From: Tom Urlings <tom.urlings@gmail.com>
Subject: using --ghost with 'program' type maps
Date: Mon, 6 Apr 2009 11:17:10 +0200
Message-ID: <200904061117.10949.tom.urlings@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

hi all,
i have been using autofs for a long time now, using it to dynamically gather 
multimedia mounts using aufs locally and across local network..
however, ghosting is not supported for 'program' maps.. which makes sharing a 
autofs mount a bit odd..

example:
server:/srv/multimedia -> automounted locally on server
: uses aufs locally to mount all multimedia type directories on local storage

client:/opt/multimedia -> automounted locally on client
: uses aufs locally to mount all multimedia type directories on local storage 
and on automounted samba shares (also on server)

when server automount is mounted on client, server:/srv/multimedia is mounted, 
but (as spec'ed) ghosting is not performed, giving an empty directory..

looks like the lookup_ghost on client does nothing as there are no cached 
entries from the mapfile (program) available.. same goes on 
server:/srv/multimedia..

could this be easily integrated into the automount source?

i have been looking into it today, but it looks a bit quirky to just 
copy/paste the lookup_file.c:lookup_read_map into 
lookup_program.c:lookup_read_map (with all ancilliaries)..

idea is to have the program maps return a complete 'file' map when given no 
key on the commandline, and to 're-use' the lookup_file.c:lookup_read_map 
functionality in the lookup_program.c:lookup_read_map

do any of you have a direction into where i should start looking?

thanks in advance..

best regards,
tom urlings

-- 
Met vriendelijke groeten,
Best regards,

Tom Urlings
