From: canon@nersc.gov
Subject: Re: fsck and already mounted filesystems
Date: Thu, 27 May 2004 08:10:52 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405271510.i4RFAqxp019860@pookie.nersc.gov>
References: <raven@themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: Message from Ian Kent <raven@themaw.net> 
	<Pine.LNX.4.58.0405261319580.20880@wombat.indigo.net.au> 
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


Sorry about the latency in my reply.

I first noticed this problem on the autofs distributed
with FC2 (4.1.2).  I tested 4.1.3 and it didn't appear to
fix it (I had noticed the patch).  Version 3.1.7 worked okay,
probably because it didn't attempt an fsck before mounting
ext2/3 file systems.  You can easily test it by creating
a map like such...

cat > /etc/auto.local << EOF
root      -fstype=ext3          :/dev/<root partition>
EOF

automount /local file /etc/auto.local

Attempting to access /local/root will fail because the
fsck failed since the file system is already mounted.

--Shane

> On Mon, 24 May 2004 canon@nersc.gov wrote:
> 
> 
> Could you be a little more specific regarding the version please.
> 
> I assume you mean 4.1.2 -> 4.1.3. Did it work before that. If so how far 
> back?
> 
> The main change here was a correction to spawn function parameters when 
> calling fsck.
> 
> Ian
> 

------------------------------------------------------------------------
Shane Canon                             voice: 510-486-6981
PSDF Project Lead                       fax:   510-486-7520
National Energy Research Scientific
  Computing Center
1 Cyclotron Road Mailstop 943-256
Berkeley, CA 94720                      canon@nersc.gov
------------------------------------------------------------------------
