From: Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] autofs: handle old configuration format
Date: Thu, 18 Jun 2015 08:39:58 +0800
Message-ID: <1434587998.2649.12.camel@pluto.fritz.box>
References: <1434558586-9442-1-git-send-email-jbacik@fb.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1434558586-9442-1-git-send-email-jbacik@fb.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Josef Bacik <jbacik@fb.com>
Cc: autofs@vger.kernel.org

Hi Josef,

Hope you are well.

On Wed, 2015-06-17 at 09:29 -0700, Josef Bacik wrote:
> This is a patch to fix
> 
> http://bugzilla.centos.org/view.php?id=8614
> 
> The configuration stuff was redone and it broke backwards compatiblity.

OK, but I put quite a bit of effort in to not do that.

I thought it more likely I'd get complaints from people not realizing an
old configuration left in place would override changes in the new
configuration.

Can you give me an example of the problem you have seen please.

> Unfortunately this was backported to Centos/RHEL, so configurations that were
> working in 6.4 suddenly broke in 6.6, which is not helpful.  Fix this by
> noticing if we are looking at the old configuration file, strip out the DEFAULT_
> bit of the variable if it is there and tolower the rest of the string.  This
> makes it so our old configuration works properly and now people get their home
> dirs automounted properly with either versions of autofs.  Thanks,

The way this is supposed to work is that the new configuration file is
read and then the old one is read and anything in the old configuration
file should override anything in the new one.

When looking up configuration values if the key isn't found and the key
starts with "DEFAULT_" the the key is looked for again without the
"DEFAULT_". Also, key comparisons are case insensitive so that shouldn't
make a difference.

And I'm pretty sure I strip white space too so extra spaces shouldn't
cause a problem either.

But clearly you have a case that I've missed which I'm keen to hear
about.
  
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  lib/defaults.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/defaults.c b/lib/defaults.c
> index 5711e65..cd43a60 100644
> --- a/lib/defaults.c
> +++ b/lib/defaults.c
> @@ -776,6 +776,27 @@ static int check_set_config_value(const char *section,
>  	return ret;
>  }
>  
> +static int check_set_old_config_value(const char *section, const char *key,
> +				      const char *value)
> +{
> +	const char *pkey = key;
> +	char lkey[PATH_MAX+1];
> +	char *plkey = &lkey[0];
> +
> +	/*
> +	 * The old format was DEFAULT_whatever, so just trim the DEFAULT_ bit if
> +	 * it's there.
> +	 */
> +	if (strstr(key, "DEFAULT_"))
> +		pkey += strlen("DEFAULT_");
> +
> +	/* Lower case everything */
> +	while (*pkey)
> +		*plkey++ = tolower(*pkey++);
> +	*plkey = '\0';
> +	return check_set_config_value(section, lkey, value);
> +}
> +
>  static int parse_line(char *line, char **sec, char **res, char **value)
>  {
>  	char *key, *val, *trailer;
> @@ -924,7 +945,10 @@ static int read_config(unsigned int to_syslog, FILE *f, const char *name)
>  				"%s is not used by autofs, ignored", res);
>  			continue;
>  		}
> -		check_set_config_value(new_sec, key, value);
> +		if (name == OLD_CONFIG_FILE)
> +			check_set_old_config_value(new_sec, key, value);
> +		else
> +			check_set_config_value(new_sec, key, value);
>  	}
>  
>  	if (!feof(f) || ferror(f)) {


