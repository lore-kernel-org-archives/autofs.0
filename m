From: "Daniel Schwager" <Daniel.Schwager@dtnet.de>
Subject: Re: different behavior in static/executable autofs map
Date: Sat, 14 Feb 2009 23:34:37 +0100
Message-ID: <EB31672367A401439CD5A4A10889D57B01297358@exchange.dtnet.de>
References: <EB31672367A401439CD5A4A10889D57B01297357@exchange.dtnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: Daniel Schwager <Daniel.Schwager@dtnet.de>, autofs@linux.kernel.org

Hi,

i tried this also on FC9 
(autofs-5.0.3-33.x86_64, 2.6.27.12-78.2.8.fc9.x86_64)

Also, the file-map works, the program-map failed. autofs 
found a "syntax-error" or "duplicate offset"

Feb 14 23:28:50 app4 automount[2599]: parse_mapent: parse(sun):
dequote(":/tmp") -> :/tmp
Feb 14 23:28:50 app4 automount[2599]: parse(sun): syntax error or
duplicate offset / -> :/tmp
Feb 14 23:28:50 app4 automount[2599]: parse(sun): error adding
multi-mount
Feb 14 23:28:50 app4 automount[2599]: cache_delete_offset_list: deleting
offset key /home/p/test1/


With the file-map, it works and I get the debugging output like
Feb 14 23:28:46 app4 automount[2599]: parse_mapent: parse(sun):
dequote(":/tmp") -> :/tmp
Feb 14 23:28:46 app4 automount[2599]: add_offset_entry: parse(sun):
added multi-mount offset / -> :/tmp
Feb 14 23:28:46 app4 automount[2599]: parse_mapent: parse(sun): gathered
options:
Feb 14 23:28:46 app4 automount[2599]: parse_mapent: parse(sun):
dequote(":/tmp") -> :/tmp
Feb 14 23:28:46 app4 automount[2599]: sun_mount: parse(sun): mounting
root /tmp/auto9XOrqS/, mountpoint test1, what :/tmp, fstype nfs, options
(null)
Feb 14 23:28:46 app4 automount[2599]: mount_mount: mount(nfs):
root=/tmp/auto9XOrqS/ name=test1 what=:/tmp, fstype=nfs, options=(null)

Maybe a bug ?

Danny
