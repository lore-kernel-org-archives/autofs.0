From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Fri, 8 Apr 2016 16:29:07 +0200
Message-ID: <20160408142907.GX15153@bccms.uni-bremen.de>
References: <20160407141906.GU15153@bccms.uni-bremen.de>
 <1460090760.3135.53.camel@themaw.net>
 <1460110224.2979.35.camel@themaw.net>
 <20160408122552.GW15153@bccms.uni-bremen.de>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SzQ167Kp6Zo0TWVn"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1460125748;
	bh=GUujQ8I43C4eWjQik6WwASMmiLkSoDugM0PX1C4tUxs=;
	h=Date:From:To:Reply-To:References:In-Reply-To;
	b=XMK1sfZxKA4H2bg21uicKPJJL+7tnttWQozmSzwVl/HUORM0LbmHp8vZ70q1m0QQe
	 PPorP2ol3VgBeMSATsy2po5pktq0/4ScMinMPov0kT9HFqijtLtYMABhlePMo8Oy39
	 AV6hfkWECxUJ9rLc/mJ4c56IlKz4NcQN/hUcNp1o=
Content-Disposition: inline
In-Reply-To: <20160408122552.GW15153@bccms.uni-bremen.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs@vger.kernel.org


--SzQ167Kp6Zo0TWVn
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

apparently I confused my 5.1.1 source built experiment and my debian
package rebuild experiment when I reported that libtirpc was used in my
last email. So here is a new try to rebuild the deb source with
--with-libtirpc.

I did a apt-get source autofs and added --with-libtirpc to debian rules.
After that it would of course not allow me to build a package, "aborting
due to unexpected upstream changes". So I just did a "dpkg-buildpackage
-b" and then dpkg -i autofs... . Attached is the file build.out.gz which
contains the stdout output. Clearly libtirpc is used somehow in the build.

After restoring maps in /etc I did a service restart autofs and with
debug loglevel I get 

Apr  8 16:20:33 core324 automount[14615]: open_mount:247: parse(sun):
cannot open mount module nfs
(/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
clnt_dg_create)

as reported. I then double checked and actually

root@core324:~# ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so
        linux-vdso.so.1 =>  (0x00007ffff7ffd000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6
(0x00007ffff79f3000)
        /lib64/ld-linux-x86-64.so.2 (0x0000555555554000)

no libtirpc. 

I will have to read up on how to properly rebuild the package. The
debian documentation is unfortunately not very user friendly, any
hints are appreciated.

Best Regards

Christof

On Fri, Apr 08, 2016 at 02:25:52PM +0200, Christof Koehler wrote:
> Hello again,
> > I've been thinking about this and I have a couple of thoughts.
> > 
> > As far a IPv6 goes using glibc RPC is, I think, not going to work!
> > 
> > That's the first thing that needs to be sorted out.
> > 
> > I've been using libtirpc in Fedora and RHEL builds for nearly 10 years
> > so I don't think the library problem is with autofs.
> > 
> > This is an indication someone is doing something a little dumb:
> > 
> > automount[20444]: open_mount:247: parse(sun): cannot open mount module
> > nfs (/usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so: undefined symbol:
> > clnt_dg_create)
> 
> concerning my failures to build autofs. First the client has all
> libtirpc packages I think are necessary:
> # dpkg -l libtirpc\*|grep ii
> ii  libtirpc-dev                                   0.2.2-5ubuntu2
> ii  libtirpc1:amd64                                0.2.2-5ubuntu2
> 
> We have libtirpc1 on the machines by default and I had to
> install libtirpc-dev so that ./configure would conclude that
> --with-libtirpc should do anything. 
> 
> Actually I tried to compile autofs 5.1.1 from source and a new 5.0.7
> package from ubuntu's source deb.
> 
> Using the sources at https://www.kernel.org/pub/linux/daemons/autofs/v5/
> I was basically confused what to do about the patches. Do I have to
> apply everything in patches-5.1.2 to autofs-5.1.1.tar.gz to get 5.1.2 ? 
> How do I do that automatically ? I noticed that autofs-5.1.1.tar.gz
> misses the patch mentioned in message 15 of
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=737679
> but contained in autofs-5.1.1-revert-fix-libtirpc-name-clash.patch.
> 
> So to make it short I certainly messed something up
> somewhere, the final binary and libs were no success . Additionally
> installation did not play nice, although --prefix= was set it overwrote
> configuration files in /etc.  But I think I
> cleaned everything up afterwards.
> 
> If someone can provide some hints I would try it again.
> 
> After that I rebuild the 5.0.7 package from source deb after adding
> --with-libtirpc to debian/rules as suggested in the bug reports. I
> installed from that package.  I checked with ldd after installing
> that ldd /usr/lib/x86_64-linux-gnu/autofs/mount_nfs.so was build with a
> reference to libtirpc. 
> 
> This try gave the error message in the ubuntu bug
> report https://bugs.launchpad.net/ubuntu/+source/autofs/+bug/1564380
> 
> So, any hints are appreciated. As long as I can stick to 5.0.7 rebuilt
> from the source deb installing/re-installing is no problem and I can try
> different things you might want. Assuming I can get the program to work :-)
> 
> Thank you very much for all your help !
> 
> 
> Best Regards
> 
> Christof
> 
> 
> 
> -- 
> Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
> Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
> Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
> 28359 Bremen  
> 
> PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in

-- 
Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen  

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/

--SzQ167Kp6Zo0TWVn
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="build.out.gz"
Content-Transfer-Encoding: base64

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

--SzQ167Kp6Zo0TWVn--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
