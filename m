From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 02:48:57 +0100
Message-ID: <20050215014857.GA26216@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Mon, Feb 14, 2005 at 10:39:51PM +0800, raven@themaw.net wrote:
> Here is autofs 4.1.4 beta2.

Thanks! :-)

I've gone through all the Debian patches again, and this needs looking into:

- 000_autofs_4.1.3_sock-leak-fix is missing.
- 035_program_mount_repeated_last_character_of_map_output is in there, but
  there looks like there's an identical situation further down. Could you
  investigate? (I'm not really sure if it is an error or not, to be honest, I
  just want it checked. :-) )
- 051_maps_without_trailing_newline.diff is not in, it seems; did you forget
  it or just find a cleaner way?
- The check for /proc/modules does not seem to have went in (see
  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=292762).

Apart from that, looks like everything went in; I'm building a new version
now and will upload after I get your feedback on the points above.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
